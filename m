Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6697E2DB674
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgLOWVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgLOWV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:21:26 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE8C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:20:45 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id m12so43467879lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLkwiClWiZEufd757VnQ12gJprYkp+uUjzIoU0sN1IY=;
        b=RqsSk46kiv+oauJQZjgoCDxigw8xhGRze+AVMrO9n70VxeBAWsZC8s+tj0XEThYaLy
         E7tNVqy6MPxOrgIG0sk6lwgqMqzCdaiCFrqsevKcuF3sPMZ3aBTF5Db7NTlQUXzcbAo/
         RdT6UQdkjsTSOnU+GNvLW9+vdESzy8j9xYsiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLkwiClWiZEufd757VnQ12gJprYkp+uUjzIoU0sN1IY=;
        b=S3J6A1OQIQcP5Co5brUaRG2xYwiptOG7W6pQRnGF/pR2lOVDlONyyjCHn2HEWe4zYt
         qvwFDb47DHyriyuzwUkV4sWSbcVJjgK8SZj74OAqOuBOXrodSIH6umjuM3Iy/3Js/51q
         KYZQfHjHCOnyxrKvVx0D4kAsvZEgfr12wzPilfGN6R96GlSEtF97XofMqNnfz394e1dr
         1XSUQKdIyqoszGdj7lAnG/fRDKkHYCGK2RHmygGOg+y07C+w/Jq4udSZcYubfDd7ChDt
         M7WAIvHxnezOAoXp0lzTnLm8lgwIhSfsNTPWmE0E+B7RB7rwZULm5VOsXjMlSDc45tE4
         kvjQ==
X-Gm-Message-State: AOAM532q0QcMUEcjxiEiatejR0iO0nunGfcZPwI3M+9ncUKMRFFTHTD0
        wrkboyE63KcNdxprgPnTCGxoNuwq6iv0cA==
X-Google-Smtp-Source: ABdhPJyQ1ammyufYMkGalnCTbrU+6EkheI3IgzBU4toRJAvDUwmjzL22lMUt8jPFdcc1ySeL50INBw==
X-Received: by 2002:a2e:9747:: with SMTP id f7mr14431059ljj.262.1608070844120;
        Tue, 15 Dec 2020 14:20:44 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v10sm3709lji.130.2020.12.15.14.20.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 14:20:43 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id a9so43443182lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:20:43 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr6681510ljy.61.1608070842610;
 Tue, 15 Dec 2020 14:20:42 -0800 (PST)
MIME-Version: 1.0
References: <X9iNTajXvwiLa1bV@kroah.com> <20201215223752.42c377d7@canb.auug.org.au>
 <X9iiwr5Lf8l8TOpP@kroah.com>
In-Reply-To: <X9iiwr5Lf8l8TOpP@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 14:20:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiu-UMhJZEUM4u+6OyMh=i8Y2RPzqd+W=JArEwhUAHG8w@mail.gmail.com>
Message-ID: <CAHk-=wiu-UMhJZEUM4u+6OyMh=i8Y2RPzqd+W=JArEwhUAHG8w@mail.gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver changes for 5.11-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 3:48 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Linus, your call.

This showed up in my build testing and I fixed it in the merge. No
problem, but thanks to Stephen for tracking these things.

             Linus
