Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9727922F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgIYUe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgIYUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:33:35 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B34C0613B4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:48:07 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y11so2996590qtn.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Vd95iFh6wCPIomS1/ZtyeUbAS6OsYbDOK3YIxNXum8=;
        b=nuW7YkGz031Jl20DOftTYfX5f9CNSvGcoZCncgGHDTMvv3tIPHEnccn6gIyJEBTHPt
         w6hVTFuWpOQ5S2y3+ygPVm0F8LfYne7+owYJ4ua6yP6Pu2ftxfNuptSjZpyUmbCGV63H
         kORa+aSKdIHPdpTZW8CKwly9n19vee5orgQAoNckSm1sibXqtncTI78FjzO2eqkChQni
         3y0D+agKRJO72YQz50kEM2Nq3cYxgm38RI3YoGBskOsTIUQLoW4sAt+5ReBN3rsXUi+Q
         b52Yw9HJcZvKnUhrE4hjdKLa97PF90NVV4b5e6IBy3ndtR7XmFYcmrLiHEx5tCvllemA
         YBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3Vd95iFh6wCPIomS1/ZtyeUbAS6OsYbDOK3YIxNXum8=;
        b=U4uITLnagmkgThEHkN//tiZJqgDVGUCt0fSZQxHcDNgyC/6QPQq56aeToQtTAHbAXY
         JE8pfKK5Xa3bt+25oWI5W99PcXhuzeh4s597Moor9hFvZ+xoM4jaIBr5tHj9x1DD/HR+
         j5kNKzqpm10v9PdJR2Xu0XeQBTCFSsO5pQkQ04uin83RkfAI381VTwJqSuEUzNMrnSeV
         JDe4AnoBVnxThZPbHfyGVi8pRwTki4fAhoCOP7poVoxGcvGBxgSuamt/XIRmhdIBFSsj
         Gy4AFM4/IeSrdXpIljU9qu/ncPwoqi3VhwMJPKkY9NdYu6g+c+zt/yNLgUlTYzQXOS4g
         aXNg==
X-Gm-Message-State: AOAM532ALQnprWt1F5BuNWPXi6HgWj1Fcm0DQjeWx7ydnfNsAjgbYptj
        KMtMiBb6xB97dDDpDC5QmzM=
X-Google-Smtp-Source: ABdhPJwtW7DPURZopZdxpofFWzgWwz1Av+16wqQ04GhH2QpmFusIEZ/EhiDsUUJpQ/dJfeIhVQ2Etw==
X-Received: by 2002:ac8:45d7:: with SMTP id e23mr1326589qto.177.1601063286707;
        Fri, 25 Sep 2020 12:48:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k12sm1029651qtu.47.2020.09.25.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 12:48:06 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 25 Sep 2020 15:48:04 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
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
Message-ID: <20200925194804.GA757220@rani.riverdale.lan>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200922201024.GS22660@zn.tnic>
 <20200922221523.GA1185357@rani.riverdale.lan>
 <20200923024529.GA15894@shbuild999.sh.intel.com>
 <20200925171631.GL16872@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925171631.GL16872@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 07:16:31PM +0200, Borislav Petkov wrote:
> On Wed, Sep 23, 2020 at 10:45:29AM +0800, Feng Tang wrote:
> > > Rather than a tool, would additional file(s) in, say,
> > > /sys/devices/system/cpu/cpu<n> be nicer? They could show the raw CPUID
> > > features, one file per leaf or sub-leaf, maybe even along with whether
> > > they were disabled at boot-time.
> > 
> > My thought is we already have in-kernel powerful /proc/cpuinfo, while 
> > a user space tool could be more flexible for text parsing/layout, and
> > show different info on user's demand/options.
> 
> The important thing here is that a separate tool would be decoupled from
> the kernel and thus will be independent from it, i.e., you can get the
> tool and run it without having to install a new kernel.
> 
> And with the CPUID leafs specified in a text file, you won't even need
> to update the tool even - just cpuid.txt. It can't get any better than
> that.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Ok. Another suggestion: while designing the format for the cpuid.txt
file, would it be possible to include enough information for
cpufeatures.h to be auto-generated from it?
