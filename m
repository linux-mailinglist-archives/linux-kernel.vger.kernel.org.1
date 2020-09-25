Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE927925A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgIYUkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIYUkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:40:51 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC21C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:40:51 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ef16so2087078qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=84FFZqRSo9JlGn0BmfnJQfSrBFnQPmj8jSYXtw0zbs0=;
        b=EkG0IBY3+9tPcP4Z7WepgCylCvcTP+y0QR8kPSLxi3nSos912TLoQO9JZxkIp5RjLe
         Lj8saaOXcaTWwUhvSLLM5s8ygmI8CqbJ+KUF+Bi6h2OU8GIKnfxpzfohOQ+7YdEe6Iaa
         DQ0VNnyHES/Wj8X9TTLuNun+W6SDXftTuGzF/iiu4c0dxpFiTV+Gpmqiul+w1Ik00mIs
         yZAfnFnx/Ls2iDe6oD4R/pEAeblD4oQVhCq+12+RA/q3zuSajOWx1lYKDFnOF619wcp3
         urkSCa9KKv1pz0jXtNAbsBfEpwWZNm5ihST5lOIFdQVtQiuTY+43gYk58Xg1gD05BmRw
         Mlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=84FFZqRSo9JlGn0BmfnJQfSrBFnQPmj8jSYXtw0zbs0=;
        b=Vm1FHTUPP7yjLcN47w3zeGIZp/f49d0Id4FMvSahfIgZlfntL8sEUuupXiadVsSPJm
         B2j7ILLKu685gO9oouT/KY7h8cD0KDBe5u0MVtvC+zV/3Gh+gKieY7K66ScL6lvfIebw
         u1uQ9he3ZpWX+RvqEzIqWMxLYCrW+Su55/D1NHwRAvZ5CZzsSKhoVFpVDXKFL85wShEj
         JV4EgRbJ8g2KU6wE8pp41vYdoSY++Idsm+v4f1H9VuI6Dv3Dzwf0TQRZx0WgMfTVheEQ
         hfd+7OwNcyq+KhWto4TZKuieRUh7o3Ew3GXM+p0OQxKv9gxDyDulW+7/Rn+nPkB3Qifj
         q/Hg==
X-Gm-Message-State: AOAM530qT/UJV0GCxMDC04YVAM13SZPBAuphrzB+MW55g2mPrKl+vPPs
        9k+ERwZLoWfcoB2r4Gkm8Mw=
X-Google-Smtp-Source: ABdhPJz/jhWWBvc0Z+aYL9NEy0DXb25kKvqo9EeUHbK6j6lzKc2ozzmKpwp80qxDTyKoxLvsdNk6gg==
X-Received: by 2002:a0c:99ef:: with SMTP id y47mr464104qve.56.1601066449377;
        Fri, 25 Sep 2020 13:40:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k20sm2819601qtb.34.2020.09.25.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 13:40:48 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 25 Sep 2020 16:40:47 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Feng Tang <feng.tang@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200925204047.GA769219@rani.riverdale.lan>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200922201024.GS22660@zn.tnic>
 <20200922221523.GA1185357@rani.riverdale.lan>
 <20200923024529.GA15894@shbuild999.sh.intel.com>
 <20200925171631.GL16872@zn.tnic>
 <20200925194804.GA757220@rani.riverdale.lan>
 <20200925201707.GQ16872@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925201707.GQ16872@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:17:07PM +0200, Borislav Petkov wrote:
> On Fri, Sep 25, 2020 at 03:48:04PM -0400, Arvind Sankar wrote:
> > Ok. Another suggestion: while designing the format for the cpuid.txt
> > file, would it be possible to include enough information for
> > cpufeatures.h to be auto-generated from it?
> 
> I think you're missing the previous discussion on this topic. In short:
> /proc/cpuinfo is not CPUID but what the kernel supports. The kcpuid tool
> is supposed to dump CPUID leafs and it should be updatable the easiest
> way possible.
> 
> Here's some more documentation which should make this more clear:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ea4e3bef4c94d5b5d8e790f37b48b7641172bcf5
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

They're not the same, but aren't there going to be quite a few common
flags between the definitions in cpufeatures.h and the definitions in
cpuid.txt? If they're both living in the kernel repo, it would be nice
for them to not duplicate what's common between them, no?

This shouldn't affect how easy it is to update, I think. The kernel
build will use whatever version is in the source tree, the tool will use
whatever version is installed under /usr/share, so the latter can be
updated without needing a new kernel.

Thanks.
