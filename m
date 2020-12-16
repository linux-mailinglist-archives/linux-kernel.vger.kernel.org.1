Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195B02DC8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgLPWHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbgLPWHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:07:46 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A459C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:07:05 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l11so52341958lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaCAgi3Re6gjp+QMDCuTI+O0mC7cGhx8CTtxCOQii7o=;
        b=GnPxGwEvz7knuiGph4kvac0mci3Kt5xudz6jSN/cD3t3NNAl/j2NdbCSLmSbw1LIUv
         sCyea2BLmSjagA897k6d4CB9oEcfnfw5h67haxUgRQ6oN27GfPLhWIwzEpNf1rq9Xy3+
         Nl2huR078qCtIBIXA6M4z7HISX/52mz5H8wLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaCAgi3Re6gjp+QMDCuTI+O0mC7cGhx8CTtxCOQii7o=;
        b=MFU6jO4yUtwJM9cyurGOwAfSJMGAProkpe5RzJfz5GKel2LmeDrTV+IyvjJ+tccQNH
         YxbI6g/MZ/PpsLdoj6tsEjcMNG/mEACjWfJJjrgC/KiCmepaNbW1zecg8/dsdrU6oXOB
         StzWx3i1e7wUCg+2F3zktzcCw5ikqOE5ZeUbNQQ9d7ZLdEKw46rOwcHRFbOzs66QFE79
         dX+I3y5pqNcqJkU8wc7HoaZPSh8VriR16VmgTA6wnyVLiiM2IZ97fg7nmmtabExlsDUH
         rQJ8cCrFh0yb9g2LOQwsEC9FnVhpU6Cvel7XxwPc8g95n3FICzfLP/2GJkyHPc3i5p6J
         PzLA==
X-Gm-Message-State: AOAM530Rv67+nxE9hbJXXKDUqErG5H/tiJSSL/hpTQf8diDqsInSOgM/
        FIP6dg27knPub7p9LO7mlZTwKmRqlsNjDg==
X-Google-Smtp-Source: ABdhPJxaib+vj1UJf47LEBu3XkfNjmHRUG8vM38KSw7j4IDrAGXla9zZeLRYuG+VyAoeuzr2Nc1HCQ==
X-Received: by 2002:ac2:4946:: with SMTP id o6mr12948160lfi.412.1608156423606;
        Wed, 16 Dec 2020 14:07:03 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id s6sm362392lfd.229.2020.12.16.14.07.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 14:07:02 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id m25so52259659lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:07:02 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr13161846lfl.41.1608156422226;
 Wed, 16 Dec 2020 14:07:02 -0800 (PST)
MIME-Version: 1.0
References: <701d4747-bbbb-dbb4-d828-63d096fcc22a@kernel.dk>
 <160815345901.27795.2544235487408028611.pr-tracker-bot@kernel.org> <20201216220422.GA19075@C02TD0UTHF1T.local>
In-Reply-To: <20201216220422.GA19075@C02TD0UTHF1T.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Dec 2020 14:06:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wja217nCNOAS_bYB35kJRSgnv29fUAUGSGMCpf-aqeycg@mail.gmail.com>
Message-ID: <CAHk-=wja217nCNOAS_bYB35kJRSgnv29fUAUGSGMCpf-aqeycg@mail.gmail.com>
Subject: Re: [PATCH] arm64: make _TIF_WORK_MASK bits contiguous (was: Re: [GIT
 PULL] TIF_NOTIFY_SIGNAL for all archs)
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        pr-tracker-bot@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 2:04 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Unfortunately the merge resolution broke the build for arm64 -- could
> you please apply the fixup below? IIUC that matches what we did in
> linux-next, and builds fine locally.

Oops. That was a bit too subtle. I didn't realize that the bits really
wanted to be contiguous, and it wasn't obvious at the point of
conflict.

Will apply your fix asap.

             Linus
