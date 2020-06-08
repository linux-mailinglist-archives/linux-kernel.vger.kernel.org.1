Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867051F1F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 21:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgFHTKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 15:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgFHTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:09:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175C6C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:09:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c17so21894999lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ym4tU45MMnDn25Yhgd7+0Tq2VQSssyVJvFlY7FBum3s=;
        b=R63Bra+tBgqvZPgopT1FJ8n2T+OgE8VA8m7mcDj+55e2Todzm9t2WJlHgbFo/Isqm6
         Ld6soz/+MFK7Kk5DnXXHBSb8xgvSJEVBif0UvuZjrjGkqPH5vuuwwq7ihLUqfSsewrML
         aeYgDYnLPIX9JxlIgql5glnikrkgxcCJI5Pis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ym4tU45MMnDn25Yhgd7+0Tq2VQSssyVJvFlY7FBum3s=;
        b=Ti6y8dlxac1F7sLFqfqcLG6Q3t3WHPuuk9mwWpuoVeFIK8QQ93U+X3e4jkYbQXM2pg
         GoUK1QNyOEMVGGO2WdsPz/x7nscL91PJDJa9vFnlrn9dwJYmQC9ZqJUn4BfRX68rOw7s
         HLJGsz769n58i5JkwufZkMpvTaiT72zKelkP01Qm7drpp+otgSEwsj+Jfb4yT4wmRNod
         7HHP31OmobwdvyRC3gXCYgLy8cGIHoB5KgBuw3D0NiwITLW5xMS0SRq6VrFBzgWPeas5
         N0pOEu+fy7zKE9n4LKcG2YRRQfgUGq+GmVHkEO9l21kZYDFDRtUOyUZ8UUpB9mgP9Xqm
         NKZA==
X-Gm-Message-State: AOAM533Jc5PReABo9GauI5cE9z+SflWY11syabKOQ8jmRMnTYVqeJIQj
        rQzmnGWTwtQc+P4tbDGvpUsmnS/5t34=
X-Google-Smtp-Source: ABdhPJw4gwfMAES6bxUNqkTwI7i6gueOdJZnDRo0h5OkHHPBkdbJdMXXJWCrcg+AK4pfe1TjL5KNBg==
X-Received: by 2002:a2e:8ed6:: with SMTP id e22mr10737763ljl.401.1591643397158;
        Mon, 08 Jun 2020 12:09:57 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b25sm4554167lff.26.2020.06.08.12.09.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:09:56 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id j12so10925775lfh.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:09:55 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr13102855lfu.192.1591643395609;
 Mon, 08 Jun 2020 12:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01591630479-ext-3636@work.hours>
In-Reply-To: <your-ad-here.call-01591630479-ext-3636@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jun 2020 12:09:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
Message-ID: <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 5.8 merge window
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 8:35 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> Please note 2 minor merge conflict resolutions below:

There was a third because of the iommu tree I merged today.

That one looked trivial too, but please double-check things anyway,

              Linus
