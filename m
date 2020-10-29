Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6775529F543
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgJ2Ta5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:30:57 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:34619 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJ2Ta5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:30:57 -0400
Received: by mail-ej1-f66.google.com with SMTP id o9so3324263ejg.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e7iXBkBeWuYCmAyEZmBvatrszkr45mNBgjzcYPbsRFI=;
        b=kVxbhH0R0MSo5NCqLNf1/ljyWlrNISNykvRpSheBz8P0Mp+hHNpy23NSD23J24w4Nm
         2nYJrQYq5G4SjctIjFZ1quINHLJtiySAm4QnxPtpJbMArKcjf5gzaf0VliOiIPBPaiAN
         uFHUIvC7ykKek3yitkJG//jmVX0Er9r45AZtu7F59NBMvmcyL2LpIH5vS3BeapjhsA25
         z8WzEq3NaczJYJqzQ7+9lPafgcFa+ntoPXhgwESk3+zIWoOQPop1qmzeIV6Zl5fpxYys
         hybVXgbhUao37pkZ/KDFUzV9wvFYkh2TN3mkeEM6YWf52bANQvOsnwvG93gjCIcM9T9W
         fvqg==
X-Gm-Message-State: AOAM531qY9Y8HuU5iZL/BRCheYPlGiOViSvbnTkOYOGit77C/qbt1uNT
        I095jByqacc0DkECEIuH2LQ=
X-Google-Smtp-Source: ABdhPJyRpa0Bn7Pvd1j7m9/omT5s0fhqt1ECraJVfgKOmiJcIGS+gsLfqvxLQLhUrs97i9uVfelWgw==
X-Received: by 2002:a17:906:f185:: with SMTP id gs5mr5533989ejb.107.1603999855456;
        Thu, 29 Oct 2020 12:30:55 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b13sm2049393edk.22.2020.10.29.12.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 12:30:54 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:30:52 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: ld.lld: error: undefined symbol: amba_driver_register
Message-ID: <20201029193052.GA389163@kozik-lap>
References: <202010291249.MFjbb8tv-lkp@intel.com>
 <CAKwvOdk82WZnCh9G8CidN9tJ6qiMaHYdN-e+Ad5kRa6C87Vfxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdk82WZnCh9G8CidN9tJ6qiMaHYdN-e+Ad5kRa6C87Vfxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 12:28:54PM -0700, Nick Desaulniers wrote:
> On Wed, Oct 28, 2020 at 9:57 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   23859ae44402f4d935b9ee548135dd1e65e2cbf4
> > commit: ea0c0ad6b6eb36726088991d97a55b99cae456d0 memory: Enable compile testing for most of the drivers
> > date:   2 months ago
> > config: arm-randconfig-r024-20201028 (attached as .config)
> 
> ^ Note, this was a randconfig, so the preprocessor guards on CONFIGs
> might be wrong.

The report looks correct. It's possible to craft ARM config without
ARM_AMBA which would cause this issue. I have a fix ready.

Best regards,
Krzysztof
