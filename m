Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACA32861B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgJGPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgJGPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:00:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9920CC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:00:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id az3so1165808pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UsP92e7ztJOmTylPESLcrgsG55YfkI2roFO/32OXJm8=;
        b=ZsoMHtmQZ2rxjybc1fxKL8N3H01jxmqdQ4RO63yWdg8SITx+IHP8ZhpPIML7VF6B0+
         aOFmGQUK+nJ61t1qVqOMnqP8G8wCSAzcyOFoIbTU8YorEG7GfuFT0xLtsYVTezu2FZ3W
         J+Jq1S526XmF5CajnoT+7/SPtapfU68vTBNvF3JocxQLvJCMHrbRhxsVV9Dc9VvEGgI8
         j+o6ceUOoqoQTzuCrG03qgPkSCj7F96F9n2m1qzFvWndwWfvq3WvkUHYDsbXU6uDiQWv
         GMrsReCcIVcYx4HkqI7vNJgX00CCJv72wcoR+1XP2T+kfK02zycGXX52xa6bQUbsLCDg
         7xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UsP92e7ztJOmTylPESLcrgsG55YfkI2roFO/32OXJm8=;
        b=RsNSC9Ehvtcyay6wi9iSpDCHcawko/1Zdj5HDIr8TG97GDNr+k2H8Ng3kpgTG5IB/5
         jc8Hkqkleknfs+tQWejnXspJ3c1CxpB1ESBKMu0CHzltE/iINyaNy91G+XduAEHO37jn
         jtYQtoz+5y+rZqsojfB92mpYxNmR9KA08uF5IIvfaqwbHXFkDbETxtadkayjII/alouh
         g21/hhe4B0n/y9BQ6rj3f3AHPJwV22fjBa2lOC8d/UWP1/B0br1/ZiKzDBDhast1JcVv
         rrTzwhaGAVpgoeWpobXI8euM44aqwtuNnAWPWwCAsm7nBS80dpzrPzVyZohoforNUHWe
         au/Q==
X-Gm-Message-State: AOAM532JpXBzXhClZS21nQ5BQNJHCdy2GbvMTpKREnnDPxCvxDiUffiP
        LmUVjjHWMl52wERy5kRdgxbaFQ2WtpMxKqaE
X-Google-Smtp-Source: ABdhPJw0g2Ytwuv9x7pWSFZQGHMLRYwuGXvc4jrEbScJL1VCDnsmSFlPdQLSZgS8tmzqwev+wnysCw==
X-Received: by 2002:a17:902:8d8f:b029:d0:cc02:8527 with SMTP id v15-20020a1709028d8fb02900d0cc028527mr3265299plo.33.1602082823047;
        Wed, 07 Oct 2020 08:00:23 -0700 (PDT)
Received: from ubuntu (36-227-138-140.dynamic-ip.hinet.net. [36.227.138.140])
        by smtp.gmail.com with ESMTPSA id 15sm3529040pgt.24.2020.10.07.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 08:00:21 -0700 (PDT)
Date:   Wed, 7 Oct 2020 23:00:13 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/uclamp: release per-task uclamp control if
 user set to default value
Message-ID: <20201007150013.GA219885@ubuntu>
References: <20200928082643.133257-1-hsiang023167@gmail.com>
 <8272de8d-9868-d419-e2bb-d5e2c0614b63@arm.com>
 <20201002053812.GA176142@ubuntu>
 <57e6b3d3-22cd-0533-cfe7-e689c7983fcc@arm.com>
 <87o8lg7gpi.derkling@matbug.net>
 <20201005171500.eztpptd76fotkwa6@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005171500.eztpptd76fotkwa6@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 06:15:00PM +0100, Qais Yousef wrote:
> On 10/05/20 18:58, Patrick Bellasi wrote:
> 
> [...]
> 
> > >> it can not go back to the initial state to let the module(group) control.
> > >
> > > In case A changes its values e.g. from 3a to 3b it will go back to be
> > > controlled by /TG again (like it was when it had no user defined
> > > values).
> > 
> > True, however it's also true that strictly speaking once a task has
> > defined a per-task value, we will always aggregate/clamp that value wrt
> > to TG and SystemWide value.
> > 
> > >> But the other tasks in the group will be affected by the group.
> > 
> > This is not clear to me.
> > 
> > All tasks in a group will be treated independently. All the tasks are
> > subject to the same _individual_ aggregation/clamping policy.
> 
> I think the confusing bit is this check in uclamp_tg_restrict()
> 
> 1085         uc_max = task_group(p)->uclamp[clamp_id];
> 1086         if (uc_req.value > uc_max.value || !uc_req.user_defined)
> 1087                 return uc_max;
> 
> If a task is !user_defined then it'll *inherit* the TG value. So you can end
> up with 2 different behaviors based on that flag. I.e: if 2 tasks have their
> util_min=0, but one is user_defined while the other isn't, the effective
> uclamp value will look different for the 2 tasks.
> 
> IIUC, Yun wants to be able to reset this user_defined flag to re-enable this
> inheritance behavior for a task. Which I agree with you, seems a sensible thing
> to allow (via new sched_setattr() flag of course).
>

Yes, this is what I want. As Dietmar and Pavan said, use 0 and 1024 to
reset user_defined is problematic. I'll send a V2 patch that use
SCHED_FLAG_UTIL_CLAMP_RESET to reset the user_defined bit.
Thank for the suggestion!

> 
> Thanks
> 
> --
> Qais Yousef
>

Thanks,
Yun
