Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A232837A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgJEOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgJEOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601907911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XyV5hB/0dQitvt3KevO7X3T92YrCjomOZnM1DMGfiBA=;
        b=iq11V04vvP5dD5SQVluBgHGqHjogR5H2cBG0Yd8bpZqEu1lXvAJfO9zO6jy32Nzc8IeiTs
        jKweP+7qwLICOM3IOhJanoBUhbNhXnsAhzpmcWpZaj+MYlV4XJSmA4LE4l+T5ijvSgveyT
        ZzNeQI6vjKTc8GCGSwQ1hdUEuq7qcVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-CH9R334rMsOsITQz4QhS3A-1; Mon, 05 Oct 2020 10:25:07 -0400
X-MC-Unique: CH9R334rMsOsITQz4QhS3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F2F085C708;
        Mon,  5 Oct 2020 14:25:05 +0000 (UTC)
Received: from treble (ovpn-119-43.rdu2.redhat.com [10.10.119.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 539B25C221;
        Mon,  5 Oct 2020 14:24:15 +0000 (UTC)
Date:   Mon, 5 Oct 2020 09:23:53 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        Matt Helsley <mhelsley@vmware.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: avoid ../ headers includes and name clashes
Message-ID: <20201005142353.q5tcvw4vf4lgd37r@treble>
References: <patch.git-cac1912eff37.your-ad-here.call-01601816519-ext-4857@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch.git-cac1912eff37.your-ad-here.call-01601816519-ext-4857@work.hours>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 03:05:42PM +0200, Vasily Gorbik wrote:
> Doesn't this make it instantly obvious where are these files come from?
> 
>  #include <objtool/warn.h>
>  #include <arch/elf.h>

Indeed, this is a lot better!  If I'm not mistaken, this conflicts with
your other series.  Would you mind rebasing this on top of the others?

-- 
Josh

