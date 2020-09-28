Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6A27B1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgI1QWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1QWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:22:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB9FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:22:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v23so1544482ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vc8J2JCpGKhtHEhzKrPh5hp7YC/MUycdmVnKBt4wwiM=;
        b=hoY1qX+rxAw6GsJIa9cUzjBWUJ47s6COzsGmGF8o/2oWUj1GagNq9Jf5pRWhUU4krB
         LfXvVVKWHY+6OoGqmDa8b2IV2VUIrpaOWwzhkIsln0e5MvfOqK2Zj7+qju4EgxFsuT/z
         BRUczxv1MQFeaHuL2dP3nAWYqsRnD/ZSOptyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vc8J2JCpGKhtHEhzKrPh5hp7YC/MUycdmVnKBt4wwiM=;
        b=XZldNlcqltOoxHV2x6A1sr+s/ubeuHVesCZgdsyZv1OuZls1KYrzKucUgAH4u2ByEl
         gOnH766d4xn2BmmhQbPHmn+BplVzVrKMEbjB7xFjgBCP54PTaXlI0CisrlTa+PLVKSdu
         gu80PazxLfURMW+FL14xpkLRUk9jJwBryMuahhymMki2QydpQEn6tpxZ8nPAPhzsiolI
         8+YAWEOZrMt48IYQY2toPzLIT12PTVHYSdkixiFBlW+EWrFcwXxq1PHq3AmswJNM/+nt
         52uO+CNeDaHGecplqH1hn/T0igyLoJhyMtes/bPiH95M2BWd44epFMqIbhJpeqM0NfXG
         ZDew==
X-Gm-Message-State: AOAM5330urK5lVZoF9y6e3XJJyNRCg1NnJra+c+MD6dTh/IL5J32W4LZ
        ERuy4q8xWjDiORV8w1nfzSSjfdlevy2k8Q==
X-Google-Smtp-Source: ABdhPJxgJDuZVDtcncgeVRmd9uSHhsA9UJrAb1X6eulU4sdCNpbhk5UOBC6aXNSCfeNBB+UGf7ewpw==
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr622471ljh.70.1601310149011;
        Mon, 28 Sep 2020 09:22:29 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v13sm2944169lfo.30.2020.09.28.09.22.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 09:22:28 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y17so1977056lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:22:27 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr694090lfa.148.1601310147685;
 Mon, 28 Sep 2020 09:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <eaa6a3d3-670f-b976-d65e-582b728d4567@skogtun.org>
In-Reply-To: <eaa6a3d3-670f-b976-d65e-582b728d4567@skogtun.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Sep 2020 09:22:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wja+yd0Qc5=mR1=3-fKZUQNL2A6tUnob6HmjLhi9Ly8sA@mail.gmail.com>
Message-ID: <CAHk-=wja+yd0Qc5=mR1=3-fKZUQNL2A6tUnob6HmjLhi9Ly8sA@mail.gmail.com>
Subject: Re: 5.9-rc7: BUG: kernel NULL pointer reference
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 7:07 AM Harald Arnesen <harald@skogtun.org> wrote:
>
> I will try bisecting if no-one has a simple explanation.

There's a simple explanation, no need to bisect.

I'll push out the fix asap,

                Linus
