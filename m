Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB4A2B18FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgKMKYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:24:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:35140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKMKY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:24:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605263067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+WTkGmdnbMkZJ6lvWOrKglzHqkfUKwJ37Bf3POufS0=;
        b=hi6ZYCuBy9LTd32MYAOl7/1g6R/j+EPAtoejSTD+03b42sEHINgv7r/acGja+X956WhVPB
        OG8xUpON2Gg2XkPlKW59eT85WuMPr/U5jjifWsNErS9amquE5QcDuE46lnzL9T7uX7CMmi
        cDVrha+nhDPvEFgBYw/gisd0ao1PvdI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA748AEFF;
        Fri, 13 Nov 2020 10:24:27 +0000 (UTC)
Date:   Fri, 13 Nov 2020 11:24:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] kthread_worker: Add
 flush delayed work func
Message-ID: <20201113102427.GI20201@alley>
References: <20201111091355.19476-1-qiang.zhang@windriver.com>
 <20201112160135.2b5720c66b020472892f2366@linux-foundation.org>
 <BYAPR11MB263258BCE554A9EFD2F3A8A7FFE60@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB263258BCE554A9EFD2F3A8A7FFE60@BYAPR11MB2632.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-11-13 08:59:37, Zhang, Qiang wrote:
> 
> 
> ________________________________________
> 发件人: Andrew Morton <akpm@linux-foundation.org>
> 发送时间: 2020年11月13日 8:01
> 收件人: Zhang, Qiang
> 抄送: pmladek@suse.com; tj@kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> 主题: Re: [PATCH] kthread_worker: Add flush delayed work func
> 
> [Please note this e-mail is from an EXTERNAL e-mail address]
> 
> On Wed, 11 Nov 2020 17:13:55 +0800 qiang.zhang@windriver.com wrote:
> 
> > Add 'kthread_flush_delayed_work' func, the principle of
> > this func is wait for a dwork to finish executing the
> > last queueing.
> >
> >We'd like to see some code which actually uses this new function
> >please.  Either in this patch or as one or more followup patches.
> >
> >btw, we call it "function", not "func".  But neither is really needed -
> >just use () to identify a function.  ie:
> 
> >: Add kthread_flush_delayed_work().  The principle of this is to wait for
> >: a dwork to finish executing the last queueing.
> 
> I don't see it being used in the kernel code so far, and I'm not sure if it's going to be used in subsequent scenarios (it like flush_delayed_work in workqueue )or whether it's currently using "kthread_work" some code needs it.

I agree with Andrew. It does not make sense to add/maintain new API
when it is not going to be used.

The kthread_worker API is used only when the kthread needs some special
scheduling policy or priority. There always will be only few users
in compare with the workqueues API. It is possible that this function
will never be necessary.

Best Regards,
Petr
