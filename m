Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4B019E7B2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 23:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDDVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 17:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgDDVNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 17:13:32 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1257206F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Apr 2020 21:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586034811;
        bh=QSQdYxF4n+C2Rff5ebcDPM4qUb8Ps/kvJP87NIZjn10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zj36C/rhVlvjmhaYlGraAy4O7oSTZ6H+4dfyCnJAum0fVYlp6WZXf2yQcaMgqKF6W
         jxuDV9BVEgrjoVs8o6p+eaQSL+dO/4jd57mQePxHgeJ65ohRiYBXUoJdg2sFr+emR5
         HRaY7a30djJgU8HHN/jV/P72nPiPXY4zhjlQ0rto=
Received: by mail-wr1-f44.google.com with SMTP id g3so10524247wrx.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 14:13:31 -0700 (PDT)
X-Gm-Message-State: AGi0PuZkhTrQPzvgcJqItn2lMcUF8YIlLjhthjnpmh82W5zfmjTlWQ96
        JDFEBFHJgVBwMk8AsKsQLBfou8lQIlTu/GBBKUs+CA==
X-Google-Smtp-Source: APiQypJna/ZsF70sTTF1V/LDvm2CwjFSuXeRQUj8l1KHa6EISwFIKQsOiHqStmcCXn7ndTC1y0NJt4Xf4pXu+Kyjrd0=
X-Received: by 2002:adf:b6a9:: with SMTP id j41mr13237615wre.70.1586034810077;
 Sat, 04 Apr 2020 14:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200404083646.8897-1-bp@alien8.de>
In-Reply-To: <20200404083646.8897-1-bp@alien8.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 4 Apr 2020 14:13:17 -0700
X-Gmail-Original-Message-ID: <CALCETrVonASsX-xR1ApbTbAHF_On=Cvok8=sB40AsbbKjnQO4w@mail.gmail.com>
Message-ID: <CALCETrVonASsX-xR1ApbTbAHF_On=Cvok8=sB40AsbbKjnQO4w@mail.gmail.com>
Subject: Re: [PATCH] x86/32: Remove CONFIG_DOUBLEFAULT
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 1:36 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> Make the doublefault exception handler unconditional on 32-bit. Yes,
> it is important to be able to catch #DF exceptions instead of silent
> reboots. Yes, the code size increase is worth every byte. And one less
> CONFIG symbol is just the cherry on top.
>
> No functional changes.
>

Acked-by: Andy Lutomirski <luto@kernel.org>
