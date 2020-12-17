Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FEB2DD685
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgLQRqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:46:49 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD374C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:46:08 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h205so16098542lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYZ4bFbRXVniDh5QYWRWv/vlHyaXaMH1YMrXoQHcb4M=;
        b=Oo0nyeDMU0Qc1WH27tM27Ja3csFbmVvuTntoYAf6fTe7bfQI8zGvYnGCcazqdvMj0i
         c4mGkpFk9h02iyp2+UkTjWSRKqG1N/q50w79arrHi9Le84XT4zS2UMr2FjYZkYo/2z8h
         K4qVvYZCiE0vbmkk7EVCWSOIK0pX+bEzj/Xbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYZ4bFbRXVniDh5QYWRWv/vlHyaXaMH1YMrXoQHcb4M=;
        b=l4M5YWXeBlQHpgGS30QDj3So8XlRHPdkjiv68gjq4sHkVl4fQ1k8DKobFNrVURJ5Rs
         6yi8De/OSwHT0zZRSGE1olXIzAQd+If4yuh5126s1HgZfRDIsFjYIocFI5rQcgIQV+SI
         nWLAhHeUPXdYzTRTeNacQsfMLpCCiNniJA01LCsVhr3zXu8klpWkwgD8rbDNIzAKrtAT
         fj1fWyrn6CMohDdrPxRnoxpLckRc4wmqXd5iVHYwCa60zapqY88cuFVJi6WuK3vaNDr0
         YAcJ3Xy5JgUq5stL5b2JFT4vas3PDinDzVm06vTjf0iEm9rIz9/mFJf5yiNFUEDLHRWo
         hOfA==
X-Gm-Message-State: AOAM533//baX4SwzlHjg1bBK7OhhAShIkQFkLWlhc2Qe01OhzE6x52Mu
        GYHzu7+hJcIeQOPbIBbmZHLpwE+Wps09cA==
X-Google-Smtp-Source: ABdhPJzyZWZN66fXrl6CFXXEP+7DnZ/2sMoA7DYPAasJymwTQViNOe+JkXwORFCV0HU4k/sykkQ0nQ==
X-Received: by 2002:a05:6512:108b:: with SMTP id j11mr16744475lfg.44.1608227166861;
        Thu, 17 Dec 2020 09:46:06 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id c141sm649477lfd.254.2020.12.17.09.46.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 09:46:06 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id m12so59645607lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:46:05 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr154936ljm.507.1608227165525;
 Thu, 17 Dec 2020 09:46:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
 <20201216044918.jdmi32dz75uboybv@treble> <CAHk-=wjMoZesNgi1yWzY3nikyR11PUxHgov561UNom5mL1R4rA@mail.gmail.com>
 <CAHk-=whpp_eo-5d0ZLpx=0X91J0ZNReZ_9riNf96z2dy24z=hw@mail.gmail.com>
 <20201216200158.akf356yrw44o2rlb@treble> <20201217104556.GT3040@hirez.programming.kicks-ass.net>
 <20201217162524.fkxiemn7aezpv7d5@treble> <CAHk-=wiJ7xt913Lf6rfeq4CyffhXwHLVZ2ZABcKHmV8cf0FArg@mail.gmail.com>
In-Reply-To: <CAHk-=wiJ7xt913Lf6rfeq4CyffhXwHLVZ2ZABcKHmV8cf0FArg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Dec 2020 09:45:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjwVFPO2xKBO0mc+u==r2zJCXSfqFnejnNJC9rw3yhOkw@mail.gmail.com>
Message-ID: <CAHk-=wjwVFPO2xKBO0mc+u==r2zJCXSfqFnejnNJC9rw3yhOkw@mail.gmail.com>
Subject: Re: New objtool warning..
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 9:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think I'll just apply this patch instead.

Commit d652d5f1eeeb ("drm/edid: fix objtool warning in
drm_cvt_modes()") has the long and boring explanation.

          Linus
