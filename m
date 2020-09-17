Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3D26D629
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgIQIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgIQIAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:00:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20166C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:00:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1053007b81a97eebdb4df7.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:7b81:a97e:ebdb:4df7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A510C1EC0286;
        Thu, 17 Sep 2020 10:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600329646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QepYPUrdCQfPP7ZtEtvksFM9JlQkCdq+XWMcdWXauHA=;
        b=NYFZlaLSjWG3vFlwDqNKfpMsuv2dgJFjZsUt4zYY88iKRBlLDNJvwhbc0GF8omxpQrA/M1
        ZXK83b6UAkrbbr7vs0QfUzSekqKBwEnMLaBVfviuvKS4xeu+FCMYC7gJl6M9i18LoWs5o4
        gqsnTf673/tD4FwIa+T1Wbrv7gPBRYc=
Date:   Thu, 17 Sep 2020 10:00:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/pti] BUILD SUCCESS WITH WARNING
 767d46ab566dd489733666efe48732d523c8c332
Message-ID: <20200917080044.GD31960@zn.tnic>
References: <5f62b7f2.Q9ixRaxJwQpWTURd%lkp@intel.com>
 <20200917061220.GB31960@zn.tnic>
 <20200917073620.GA4946@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917073620.GA4946@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:36:20PM +0800, Philip Li wrote:
> The 2nd type is this one, which is a summarized report of head
> to provide an overview. Most of time, repo owner can receive the
> bisected mail. For this time, the issue is reported against peterz-queue
> repo which has this 767d46ab56 head firstly. Since the head later appears
> in tip, we just gather all issues and send the summary to tip related
> recipients. But no more bisected mail.

Yeah, but that second report is not very helpful because nowhere it says
it is a summary and nowhere it has that link you pasted above so that
some other maintainer can go look.

Always put yourself in the recipient's shoes and ask yourself: "what can
the recipient do with this report and does it have everything in there
required to be able to reproduce the issue?"

If not, then it needs changing.

> We will consider how to show useful produce info in summary report as
> the feedback here, which is quite useful, such like pointing to the
> bisected mail. This would take some time, and we will add to our TODO
> as high priority.

Yes, that would be much appreciated. You can also tag your reports with
a unique hash which is then in an URL so that one can go and download the
.config and what else is needed. For example...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
