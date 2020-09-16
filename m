Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE6026CAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgIPUSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728185AbgIPUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600287481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dvXaBblBv6O2xbnB7uwXvTJkSwv16X1XAJGYmhLL3sI=;
        b=H3YwLq2khEFh00e0TB49r9RuhImgh8e5gEUOrRlJPXDoQ66OM+AysVvMzZS+NSKbmb8Hzn
        ipZqSRbZkaUumt4rio5lKe/V9TypYI//MM0HH7vQGbgalaVOPUKhRcckcrNjuZLYx9gBVX
        q5/hibYLeqggwAZ5Y7cDZc1gfPuL1fQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-G0wKIuSxOpaBlfAsIhTuSg-1; Wed, 16 Sep 2020 16:17:57 -0400
X-MC-Unique: G0wKIuSxOpaBlfAsIhTuSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7B4E801AAB;
        Wed, 16 Sep 2020 20:17:55 +0000 (UTC)
Received: from redhat.com (ovpn-112-64.phx2.redhat.com [10.3.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8183614F5;
        Wed, 16 Sep 2020 20:17:55 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.94)
        (envelope-from <fche@redhat.com>)
        id 1kIdsH-00065v-Q8; Wed, 16 Sep 2020 16:17:53 -0400
Date:   Wed, 16 Sep 2020 16:17:53 -0400
From:   "Frank Ch. Eigler" <fche@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf probe: Support debuginfod client
Message-ID: <20200916201753.GC16238@redhat.com>
References: <160027467316.803747.10741549521899847231.stgit@devnote2>
 <20200916181307.GB16238@redhat.com>
 <20200916185218.GA1322686@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916185218.GA1322686@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

> > Nice, even uses the source code fetching part of the webapi!
> 
> So, can I take that as an Acked-by or Reviewed-by? 

Sure.

> I need to support this in pahole...

pahole/dwarves use elfutils, so it already has automatic support.

https://sourceware.org/elfutils/Debuginfod.html

- FChE

