Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D392C1FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgKXI1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730539AbgKXI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:27:21 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC99C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:27:20 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so27620119lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBG2wuxnRkC9gcLJv65Hd93EbCvk6yLiiTuCJFuSKhA=;
        b=v3LtVA2V7vd+LPwQ55XgnwBWrfofD+uJMR3lP30KYtdZOmmzoekDfsQAx5cocCjoE8
         1XuKNd05AYCLpk+nsqRuAxJksdfqhv0oQC0GArcAPAsWyy2XEbNRTSyWe9KVGtBND6Cf
         VGa8BfXKSjpG6HR8O6lx2efo3b1YnQp3HbgxH/o/WCzqdt1Cm7xJDdI7UvWqEgREJjBE
         R8dXJ99mbCA4emz7f9imBOH0YHPv3sX9L554J9B+JqxxvyrEOd/sS6oVUBSrAvZKAR5u
         Sr2oozJafHUpClT3La3xARkFRdCdius0zpYQLOh5Xbxg2/1qn7NNG+Py6uigLm27+55T
         PIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBG2wuxnRkC9gcLJv65Hd93EbCvk6yLiiTuCJFuSKhA=;
        b=kNUCvCDJk5cCES1Yrd1klwTU30Tl4/SUpL9/kChtaepAVGxe0+uyrLnwCGTzS3HJD9
         bIHSd7PCOFh9nWA9F50ET+dHQkhR47N4n8drP8tKWBcsZlGuu0MVLFpM8JHabbf+vIbB
         X7d3LStNqQeZc+8uehBDD0ZJofu95sN148TMssWKGVcMVBx3SQgw3pqGK/YyGbegXUX5
         RGLxyxqugx7aNcqIqNr9V/VGBuR2LYCvXwmLJMgAyeiHt6FShi4jOSDLZiwLNdEHuU0l
         s/+WLPNQ42ylzp6R8+y7/OLN4Fi/AyhbCk0L33JIwDGUmj8a0ZEHF9hK8Aj6T3vDE1fP
         pSyg==
X-Gm-Message-State: AOAM533QMuqfi3SP9XajU8Hyd7ZKM8a6FNtvM2PutkcBgNa8T/655IoN
        Pqhf+iOg4nOac74F/y2q2hrtiBQaKz2fzYds48fB2w==
X-Google-Smtp-Source: ABdhPJyhticdWKrjDkzF+0slKKn4WLxmhg8anIrWRKz+5xkruyZ3CncU+SLWT7saZibhsIMQAsaWX795xF2f1l30hZY=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr1407528lfc.260.1606206438621;
 Tue, 24 Nov 2020 00:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20201123160139.1.I2702919afc253e2a451bebc3b701b462b2d22344@changeid>
 <20201123160139.3.I771b6594b2a4d5b7fe7e12a991a6640f46386e8d@changeid>
In-Reply-To: <20201123160139.3.I771b6594b2a4d5b7fe7e12a991a6640f46386e8d@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Nov 2020 09:27:07 +0100
Message-ID: <CACRpkdZA2od6NfNczeVh4v1D4_UBHrErQLHjyGRXWOVPh9f8hQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: qcom: Clear possible pending irq when
 remuxing GPIOs
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maulik Shah <mkshah@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 1:02 AM Douglas Anderson <dianders@chromium.org> wrote:

> Conceptually, we can envision the input on Qualcomm SoCs to pass
> through a bunch of blocks between coming into the chip and becoming a
> GPIO interrupt.

This looks like really good detective engineering, something
I do myself from time to time.

Bjorn does this look OK to you?

I'm wondering about patch 1/3, does it need to be applied
with the rest?

Yours,
Linus Walleij
