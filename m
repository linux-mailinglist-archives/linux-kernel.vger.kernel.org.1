Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE726C703
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgIPSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727284AbgIPSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600279994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VB5xKGMapQSUWql5SFlvbGAVp94UGGxGnf5Md5967rg=;
        b=c7otAil4FPPlAqh/odZW8fMSAfWK+z0OOIcs1j4pL3IztdeSvHXhjdQux/darSVwp3bfFl
        cBcI64GH41M8S0hvhHLj0Pfo+mBnhydPKAFHTZAmJRt9+TZy7ZqIvWGZZUmJLQk8llD3Ac
        Gq+SMA/Wf4jNigzIvVEBccgBFax9afs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-aPkOwdwBNZiVHlqhJsMaCQ-1; Wed, 16 Sep 2020 14:13:10 -0400
X-MC-Unique: aPkOwdwBNZiVHlqhJsMaCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78F93100670D;
        Wed, 16 Sep 2020 18:13:09 +0000 (UTC)
Received: from redhat.com (ovpn-112-64.phx2.redhat.com [10.3.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5876058;
        Wed, 16 Sep 2020 18:13:09 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.94)
        (envelope-from <fche@redhat.com>)
        id 1kIbvX-0005tV-Co; Wed, 16 Sep 2020 14:13:07 -0400
Date:   Wed, 16 Sep 2020 14:13:07 -0400
From:   "Frank Ch. Eigler" <fche@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf probe: Support debuginfod client
Message-ID: <20200916181307.GB16238@redhat.com>
References: <160027467316.803747.10741549521899847231.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160027467316.803747.10741549521899847231.stgit@devnote2>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

Nice, even uses the source code fetching part of the webapi!

- FChE

