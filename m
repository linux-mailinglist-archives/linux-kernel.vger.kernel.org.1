Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5985F30104E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbhAVWtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbhAVWsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:48:08 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83514C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:47:17 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a8so9738985lfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8DBo+3az7BAKGR0xK3FPrRAWSUVaBrNe0KbRRSshgI=;
        b=jn7yOch4Fm8cZ2ofEq9dNtc+Rrjb/gsS32vANzZkx8faLtTk0rs7KSQZVdOVHWINKl
         IkUxGPY9esiJIBt5M9eByLUX+bVrxkorgHQzmGMNSUrOTwgzPwzTshn/f2HPKjjZtTAO
         pHTAXoOjaCKLuMvWPjcpA2B1P8rtuJQMQ/uzny2AxiSRCELNcRmsD1v+/9Tq9xjgic2R
         bjqSyh7sraS4bUbjaxRF8KX7erKeMag6BRc9Rv0R9Z0RZiibS4w7b4RttsmWtHyhPeJY
         vwXK7ucwxIOUVp7VoI7A63R2WloENMMKnW5AkJdoQfm7gfGdGyrShtLqbZKxeu8qbD1Y
         WuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8DBo+3az7BAKGR0xK3FPrRAWSUVaBrNe0KbRRSshgI=;
        b=kF8M5xLpX03UjyzZ7cqwDlf6c/qTqA17zmuEzFOX1V4PlKFlDqyho8mM69HqaOLwtH
         2bcrYJGf291820EBaIrJ4jQynuVFRDj8ul/DGttcudvhk7IL4n18BcUjXNAnjjRSS/dB
         fIlDpfC8l7P/R3w7I4qBINCw5Ph19Q26tw3LL7c/v40d3Is4N3p4lf3PZdk5zjw9N57S
         Ye0QxH5OkLNDossl/ikaDX45kr7OJi96m0e3xAzsyb7wBj7ER25YXtTONLpVHTyFnToE
         17t3mQJjl1NXAFmkLjy7pJs2BSxFQB1/by9znUnGQapjpjDcttjAegF6hSAxMNR5k4My
         440w==
X-Gm-Message-State: AOAM530NnyieR6y+WP3eBLnZreV9W67qJoS9hzZya6/GtuSWn8B9eJrs
        RzWlduIWSDRSCt4LVVgsFLzppBX4kzaHJYk0KAUdGw==
X-Google-Smtp-Source: ABdhPJyeGmS5zVRybraMXDpsOXKNEGknSCi7E8AaXl3185HqRzaBdMfR+yx/INuTHtBt7EVvWimuMUqdH1gc9rmrOdg=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr3360818lfe.29.1611355635977;
 Fri, 22 Jan 2021 14:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20210121114907.109267-1-bianpan2016@163.com>
In-Reply-To: <20210121114907.109267-1-bianpan2016@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 23:47:05 +0100
Message-ID: <CACRpkdZzVY=AKFhW-hEmCAHmdMgVF8=hQeE8a8W=2W0h44eQVg@mail.gmail.com>
Subject: Re: [PATCH] bus: qcom: Put child node before return
To:     Pan Bian <bianpan2016@163.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:49 PM Pan Bian <bianpan2016@163.com> wrote:

> Put child node before return to fix potential reference count leak.
> Generally, the reference count of child is incremented and decremented
> automatically in the macro for_each_available_child_of_node() and should
> be decremented manually if the loop is broken in loop body.
>
> Fixes: 335a12754808 ("bus: qcom: add EBI2 driver")
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please submit this patch for inclusion through the ARM SoC tree.

Yours,
Linus Walleij
