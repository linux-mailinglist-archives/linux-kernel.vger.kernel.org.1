Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FAC2CE1DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgLCWfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgLCWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:35:37 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346ABC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:34:57 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id t6so5039383lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 14:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPqbqnUEnkWeeVcA9Ivg1ZBfhCxd+q6cSwKDsuSVW9Q=;
        b=hDZqi3hqZVw3Nx0Hn7CoAuER/OvORTezXtXnvgKV3ER4hLO95kr/ajwbehZnQKcFso
         GolO5HCPno+0xCM7TGbrnl4nDmpzCLgx7kYqpQy3dLb+Zk+nHPQ27OR6SVI+z8Zpe3Es
         MtGNPftm3EuKFMR8SQbJkIq457Fj3zS/BG8CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPqbqnUEnkWeeVcA9Ivg1ZBfhCxd+q6cSwKDsuSVW9Q=;
        b=Ck5zVRnEJeDE5cfO27MLXJG0GfFtxGE8LgA+O8T2TrSnjZsMy/M7HIZY02BXTIuHA5
         sMxeN8DPgIIjG55pQOuuCNr2PFD9n/CIUV2CL8rert1ZvW6WklTSPGATt8zhsWJwZbrA
         k6RM4P3coaO9c0C4jQUmygy9gut+mLHI2zjiYxaQGoR4gKiM5uOy/qs6Wnc7FZt6SgeK
         6rzOl7ROqqbVc3iOWZckwqMASheA+7D4FIAGWmFA+ftYKcIgVVn4AA0eJo6UxSmeWBLf
         94dLWTtQiG4emsBrOgy9L4B/g9GZP0N+QbM18S7tc68GcASRCF9LNJxoDp5Q319Rz2zp
         GURw==
X-Gm-Message-State: AOAM530xxNHDcoTQvazPDzD2/kboMQlhGScQlweTbBHRXkYi3U3iGHza
        wgN4vqzDKnKRnu8vPnBYfTiDxSEwdWvUyA==
X-Google-Smtp-Source: ABdhPJzViJMYyIl+D6JdduNgHgVkZDQBjynL4WZKvO3gBQ/+CJwsJnwUyhdOeIBg8ZXWOSN1GM2Kzg==
X-Received: by 2002:ac2:5625:: with SMTP id b5mr2220744lff.498.1607034895370;
        Thu, 03 Dec 2020 14:34:55 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u21sm998455lfq.90.2020.12.03.14.34.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 14:34:53 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id u19so5072426lfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 14:34:53 -0800 (PST)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr2099404lfc.344.1607034892834;
 Thu, 03 Dec 2020 14:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20201203103315.GA3298@nautica> <CAHk-=wigRSokT5YLRGH5Jyun1CwgYHR_1RMcoHjUyz7NJ8wG_g@mail.gmail.com>
 <20201203221456.GA20620@nautica>
In-Reply-To: <20201203221456.GA20620@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Dec 2020 14:34:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjh2=Afx3Eb18RW_APaBKMppmpCpAfFd+n_4DttWJeFow@mail.gmail.com>
Message-ID: <CAHk-=wjh2=Afx3Eb18RW_APaBKMppmpCpAfFd+n_4DttWJeFow@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.10-rc7 (restore splice ops)
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:15 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> The problems I had with dkim are all lists that add footers so really
> not much to do about header filtering

Yeah, that's obviously always going to be a problem with DKIM.

But I think all the kernel mailing lists are good now - at least
partly because I used to complain about it.

The one thing that vger still does - or at least did not that long ago
- is to change whitespace in headers. But that is perfectly acceptable
SMTP behavior, and it's a problem only when somebody is using
"c=strict/strict" in their DKIM setup. And honestly, that's a
completely invalid DKIM setting, I don't understand how the DKIM
people ever thought it was ok (probably some company politics or other
because some vendor was too incompetent to implement the proper
relaxed hashing).

          Linus
