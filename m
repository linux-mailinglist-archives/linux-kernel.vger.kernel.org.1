Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10772F2188
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389740AbhAKVHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbhAKVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:07:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678FEC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:06:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y12so292120pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=wR8DkUvMNn7R/30CH3+3fJzHsVRXVDomopnQydl1LY0=;
        b=Hxm8+te8chJ1v8opBLWZlSz1RBuZEZ42iLk/gNVQy1nsChpsJG5VZOF9vI/Zqu74P0
         D5PUiCZtR9UL20UVRISiNcLubomcwC1eC8xchlXA1rdoctXuvW87hT9hF/ZhxpZp0Xht
         1/HK8TeXbyGgxkKSi7O+NHCJrkaBuhVXHAOVUvgOwmVI7/QzisR60Lr8n+p6zn/94iop
         ylgHG2jk/n6nnuWNsjby2sNwfPWDl8H9h0xo35dEX2er88zdB1ERBorvergSa23p3YyO
         CR+hrlc1aehSYHn3Ztje8Ykq1BjUe//g/MMlkGuESCRdEePuNSg+k6VjvfW3rfLBXC3z
         /Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=wR8DkUvMNn7R/30CH3+3fJzHsVRXVDomopnQydl1LY0=;
        b=mrtHaoTvTAB3DwoVvWDaT+AwFcgG0JeaPJdoOqKRYWrCQH4PZPgrkNE9x9/uEuzimn
         NV/5sWzwz5evWP9UNghaMTqgrvxThO1ioFanyTeYlLSEaqDK7D46E8NHJ9bycy0cBT59
         wISiRZ9NedPJseii8TcsqSGjK0Mntq/4kmu3B/LVnlsbxEtM/HJAURWKqPXrgbh/e4q6
         XANIBf9TZgU6nNfp+zReTYLWUBu+MAj0JJLcFCm//BZEdNLsn/gjxbl/WoMIlrB9S+xZ
         kdW2SUiFSJz0Lj0hxD5IRB3dQ8mqYjNxWoOr5SuKyyZMrxX+b9DD9khgYmXCnJjVZWDD
         Fb/w==
X-Gm-Message-State: AOAM532PKl+DqfhjHSe1n/rDDnFPI6UDGDmAh6R5Gy/Iuln+BjzIcniU
        rma3d1S0KeCWgoG0oadBIxiDMg==
X-Google-Smtp-Source: ABdhPJwo631GOEqRqXR7D5ZRF3A2z7fUYbCCz31BCoFCs/0kbtVKZXHhYfoyYf6pEs4Uv7+dTs8LiA==
X-Received: by 2002:a17:902:b493:b029:dc:3e1d:4dda with SMTP id y19-20020a170902b493b02900dc3e1d4ddamr1199044plr.48.1610399215932;
        Mon, 11 Jan 2021 13:06:55 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:4d0d:5741:f5e3:172? ([2601:646:c200:1ef2:4d0d:5741:f5e3:172])
        by smtp.gmail.com with ESMTPSA id t6sm307950pjg.49.2021.01.11.13.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 13:06:55 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: gdbserver + fsgsbase kaputt
Date:   Mon, 11 Jan 2021 13:06:54 -0800
Message-Id: <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
References: <20210111200027.GH25645@zn.tnic>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>, tdevries@suse.com,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20210111200027.GH25645@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 11, 2021, at 12:00 PM, Borislav Petkov <bp@alien8.de> wrote:
> 


> Or do you mean I should add "unsafe_fsgsbase" to grub cmdline and bisect
> with fsgsbase enabled in all test kernels?

Yes. But I can also look myself in a bit.

