Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC91B2FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 21:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgDUTKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 15:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726001AbgDUTKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:10:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE31C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:10:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z26so15154829ljz.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ajj5Q+DdYTDZzsTrHebQKgCxBHJoa9tpFwRTxZ5/p6Y=;
        b=T8xwxOgULy4Fxj6V9wsOjFc+COJFgPQFOMHn2kJaGKIUwhUYF1pWBLTgt+ezr/6qZG
         VKY/wUxTYirJfWP5zMwCqDpU/jw7xyxJwepTGzLi4lsoxxZmUY8gXfn0OzBvORHd0x79
         u6pQ5+ZOFbhPUVNGeK55xvK34N9WwTQRbiiNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ajj5Q+DdYTDZzsTrHebQKgCxBHJoa9tpFwRTxZ5/p6Y=;
        b=frYju5gjcC1fXjYzDIHaaO1gN74Rsfh5A8Rusymc+8ZthVNnEWRfT38ODlqFOtK7rx
         kuJsCXGrGxoAhz5OSyuWssp4xHBxWS0pusHgXtwFpUCJVKynpgJtHXb5WgNoPVT54x7I
         lY225M/qO5zMRyabP9DBNIy/aEHnxQx7WuXTQTvpjmvzFz5VmBNLtnOQIHPMN8EI4RL2
         71XRNGsPuWGamv9cY1g9Ht3I2LbA+6tmrs6EQDdZndSke9YV/psPbxq6wGiUttSNnifu
         28ADpBdK0DpHN7cw9D5irOHKqBjQ9dlNciNAGlwThnp4Vo013NN36C7pcLiWa/pLs60w
         AkYg==
X-Gm-Message-State: AGi0PuYaeJkR/tYYzeMlDu8HoyAxMA44VkSY1OR//AtRPtoW9g6z/eAV
        mRxgafUAfzQOigIPvCYCvWPSAiBKcGI=
X-Google-Smtp-Source: APiQypLF6p741Lq47nrHogGuWkRCvwHfJ6SSGitsjcxVp4UhMAIMiI08iqj4lFIghRQeKPZfxQWymA==
X-Received: by 2002:a2e:89cf:: with SMTP id c15mr7875037ljk.149.1587496203705;
        Tue, 21 Apr 2020 12:10:03 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id x23sm2742429lfe.51.2020.04.21.12.10.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 12:10:02 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 198so12036586lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:10:02 -0700 (PDT)
X-Received: by 2002:a19:7706:: with SMTP id s6mr14637564lfc.31.1587496202252;
 Tue, 21 Apr 2020 12:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200420190916.GA11695@gmail.com>
In-Reply-To: <20200420190916.GA11695@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 12:09:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiejBvKnrDysDva=DNFgyX02TZred_JMjzUnjFgVOUtOg@mail.gmail.com>
Message-ID: <CAHk-=wiejBvKnrDysDva=DNFgyX02TZred_JMjzUnjFgVOUtOg@mail.gmail.com>
Subject: Re: [GIT PULL] clang-format for v5.7-rc3
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:09 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>  - Don't indent C++ namespaces (Ian Rogers)

I've taken this, since it doesn't matter, but I'm wondering at the
motivation for it (exactly because it shouldn't matter).

                   Linus
