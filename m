Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466282DA27F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 22:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503630AbgLNVVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 16:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503619AbgLNVVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 16:21:34 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB8C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:20:54 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y19so33843186lfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nppYV01G0w/PZbHUETpgd5hc6WMH2sg1LDqQ15HDMoM=;
        b=S6+do4i0nzVdCwdDeL+Ai7jYGrGmeJmiH34CSiA25Dkp8w2hx4ALNIO2LcyIku5AP3
         T/kVlnvzRP8g7n5elPQlNRZHGZMvoZQPkq8hrpOGZoeTZvpuNprhgQJgnV2dg4e5MfDa
         /SBNOAIRfxuNLG7LEXWqlj0tDlaCKTk/M26wD+fGh0m0/eI5xPnD1PqDLxKvrYrHJDpH
         N1K83YximuB6Gq23HGTVs+lzF+duoOAPgQdTxbzeLOr+NRXwnjiXsar4To/akc/DiYF6
         JX5FhAoOuq+bbG4M/tWFBM8YotUGd+M+m7MjxtXoWR+yRkG+e+CxKPrfUQ2PfBtIjiQM
         1KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nppYV01G0w/PZbHUETpgd5hc6WMH2sg1LDqQ15HDMoM=;
        b=UD0Hg2sip4E1cA83QhYAY7G1OqVTfCnoJKvICu+TVoJCMT+SJlLz17jd0xCxZA6n6d
         DKRWd+UvThTGhgLBWhjLBMjCnSxCAfgCmAb6H/nkFWeXR3xTvi02ngLQ+mMKduwBB5m9
         7JvJOm5+fHpEUaexE8SYfj13Dp69OLkvz2DGxwb+2lrO9Drhpd9+uV+BVQT8atmiHA8d
         d7BU3iSzvylqxU11bxX7ONc7ZgFZR1XF57LY/RuJwNL0bG3+3Z5y2ZmU92CHdl0Fndqc
         4FORZuaJtT78piAAFMRMawRSQdUbCxD0rMv00NXsPCduci3Yd4ST9gZmIL81ZYmKf9ya
         YrGQ==
X-Gm-Message-State: AOAM531PF7TJCVRwGpaYhvajiNz/PCHDhSMQ4isAAgR0NrmEYIPGXUIY
        q+X4Ff2zuciarknblAC/FNOL1j+e3w3eLnepyGM3Djb9Dki8ug==
X-Google-Smtp-Source: ABdhPJx8ATWoGNVDyy7Lb1jSfwGjgep+fpg1y+tha9ZGtoANhHdYZhWolU0Fvw88o7ztZXlmPYAX4w4PT3wmhYYIQ24=
X-Received: by 2002:a2e:94d0:: with SMTP id r16mr11595908ljh.123.1607980852569;
 Mon, 14 Dec 2020 13:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20201117025522.1874864-1-rkir@google.com>
In-Reply-To: <20201117025522.1874864-1-rkir@google.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Mon, 14 Dec 2020 13:20:41 -0800
Message-ID: <CAOGAQerMMg5+WgfebtFO3nut47QKa9QtpWxg3Eb3cR2ri3pRTQ@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: platform: retire arch/x86/platform/goldfish
To:     dvhart@infradead.org, andy@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Lingfeng Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 6:55 PM <rkir@google.com> wrote:
>
> From: Roman Kiryanov <rkir@google.com>
>
> The Android Studio Emulator (aka goldfish) does not
> use arch/x86/platform/goldfish since 5.4 kernel.
>
> Signed-off-by: Roman Kiryanov <rkir@google.com>

Gentle ping.
