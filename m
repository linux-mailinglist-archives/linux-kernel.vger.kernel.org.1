Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1696A2E7B26
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 17:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgL3QxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgL3QxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 11:53:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C151FC06179B;
        Wed, 30 Dec 2020 08:52:19 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id b9so22658001ejy.0;
        Wed, 30 Dec 2020 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JvNSrPtAENxfYW4FrQD5sjwcFArArNdPq8pq28l/yAM=;
        b=JMv9uE6EBZx89gOeDuhTi4nCtDVhbXSoBqZmS+keUvyK+eOnc50ijx0GE+ZR3uR+/Y
         xThlfTwfSlHy0vzvG9o2K8zm+NkIZf3iFFOqPt9yVqnOJdcQbKQM0OfPIyUTnnhOWlg2
         y0+W1z7pLYcEMTdT+uei6b8WoOseEbHff/ERW29urfMx20fDSj/W1Zc6OjpWz1iLYeAR
         zKG/WynlnfTzZa7SoPhZeZAD76bAjftex6BcBG7R4YR2xwn6fREE+l+SAKKfLyM2VTYB
         EQTiGK09qR01WZH3lHFc4fBrcsSz3OfE1WQQDBzxj88tPW+zDK9dWK2pxF7FBxc4s2N7
         aNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvNSrPtAENxfYW4FrQD5sjwcFArArNdPq8pq28l/yAM=;
        b=b45AdDfbPJGoj8b/5gt4F73QL1jjhrm+S1OyVq1cL8Vyt2u7h37SIwy2P9KLIdRjLC
         kNQnfk59oLx+Y35GAVT/xanT1KkpJWSWMsEcnszf/PvUx4siLqHI0YHZ7T7esJhGVu3R
         o4Ck0riQNB8UkPdd7yC2nxt9UH1sU79p0H/k8tSSfzub9BvAmcDWrZ9MntG7xlv9M1nG
         Vo7ZeBtFXO70ZZxCLXI8QPr59LItsMdOsrPrw+w3/WibGszDzhycgwAwmJsCx+RluwwT
         iHvNHN/Ou1Cga7KDCJkfEuJ226hkPCg8vqWCFOCnnj0T7gMZLfiVapDUHMMe4q+IW1z7
         xBKA==
X-Gm-Message-State: AOAM531xFfZAKQrezwJeEki0lF70pp4GTXR2qtL+urTnBGLg7SHXvTKV
        idcahR6cqSfsWS8HfhwkSqxhIUB/29K9Q67bbmc=
X-Google-Smtp-Source: ABdhPJxwp3OqOZa7CHXmPjtXDOIJv3UynWcLXzFEKnN49lyK4u8QKTGi3RcXxaa3t2ZMPw2w1LBcf3ewlZM/yACzX6E=
X-Received: by 2002:a17:906:2612:: with SMTP id h18mr51083923ejc.469.1609347138534;
 Wed, 30 Dec 2020 08:52:18 -0800 (PST)
MIME-Version: 1.0
References: <1609339156-61806-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1609339156-61806-1-git-send-email-guoren@kernel.org>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Wed, 30 Dec 2020 18:52:00 +0200
Message-ID: <CAOJsxLEcuJp2EU7UdPTEB6YM5DU8_93DSQdy3dMMMPaAnz16eQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: abort uaccess retries upon fatal signal
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 4:40 PM <guoren@kernel.org> wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Pick up the patch from the 'Link' made by Mark Rutland. Keep the
> same with x86, arm, arm64, arc, sh, power.
>
> Link: https://lore.kernel.org/linux-arm-kernel/1499782763-31418-1-git-send-email-mark.rutland@arm.com/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>
