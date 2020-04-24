Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6FE1B6C64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 06:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgDXEGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 00:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgDXEGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:06:03 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888EEC09B047
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 21:06:03 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b13so10215646oti.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bp7bLiuTsfsWWKh/d49PwuT5rZ0JwxKcojUgMRnOFEI=;
        b=Nu33gOA8niDaEdLvN8wgAlhCI7kCWoYqolpkmVpInY8Z06MQCgDjfMX49Y+oVOmZtx
         ODAzh7G7HrkINIviJIEo5Li2eA0u/U2zXSXC7zpOAPPRGk7I2Z3GfZnqOoQ6wI+VH0w5
         /oyTJS9tCM8GsO8IHQ+252MCDnwO6RwkWXBSLVCdsKUpqFg78c63KzZ7AEOtrVriYTCw
         kcpA26l2byANp9rQdUX1EvDk04VBBEqknDRqjmS51TrcJw6ApBGvZuG8imfmb6QsuTVu
         +RAhpGZluictRESlw0RfnGqQqfoJ7+IGhEg6KCUespkLiZaKgVUz5UDto/UtPEqPThOI
         8A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bp7bLiuTsfsWWKh/d49PwuT5rZ0JwxKcojUgMRnOFEI=;
        b=ImrgBHANSiCAAhw5OHtDnahxtzv2GV+KyQa2Th0gIX21477cgg8ALxBZ0tA4ErIfiB
         Bjoigm1UQMgxL4Tt2CBEfvqN4KG07ql0udJzNRPzTpcpUCAqhH2+Yyzke12+9gpNfScC
         i/QPn6uWH/FgWSgWD68qPSea0aSlPcisBFr7mkzlxi4g7Qcp8Fv2NUoD2hPxehPHm3z1
         wTp3iMv8uS5xNPYitheXWOsui+9NGY9TtTCfmauksMz+LWmDLyIC+XBhvkapEzdeuBQg
         qBhDdsnh95lD8vGzLBowf41tw/BQnnGxkJveZDhJiUb0zWpUfAZb+EFBLyb83dgQvZSd
         +n5w==
X-Gm-Message-State: AGi0PuakDdBF8ecD3g7ggRAhyqDFw0CQUjXlPa2lQaoadHqpIdqeO/Bt
        Dlv8ZNfekG26gyLKptKWhCqrTVJvwLzBWinpAhkmwvxB
X-Google-Smtp-Source: APiQypICLLkZsxvRZ82zTGoSs74K9wdNIuuFRe+atFJcMRtKX5SCjZvsA1yTcpkMd0TVPp369IIUO+UGIL/p4xFojtY=
X-Received: by 2002:a54:4f02:: with SMTP id e2mr5845188oiy.10.1587701162614;
 Thu, 23 Apr 2020 21:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200421041815.1808-1-john.stultz@linaro.org>
In-Reply-To: <20200421041815.1808-1-john.stultz@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 23 Apr 2020 21:05:52 -0700
Message-ID: <CALAqxLUHLqoYAZRvF1HjHhOJPdztYh9oz=L0kEuYun7y6fBzGA@mail.gmail.com>
Subject: Re: [RESEND x2][PATCH v2] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy"
 compat string
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 9:18 PM John Stultz <john.stultz@linaro.org> wrote:
>
> This patch fixes a regression in 5.7-rc1+
>
> In commit 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2
> PHY support"), the change was made to add "qcom,qusb2-v2-phy"
> as a generic compat string. However the change also removed
> the "qcom,sdm845-qusb2-phy" compat string, which is documented
> in the binding and already in use.
>
> This patch re-adds the "qcom,sdm845-qusb2-phy" compat string
> which allows the driver to continue to work with existing dts
> entries such as found on the db845c.

I hate to be a bother on this, but I'd really like to see this
regression resolved.  This fix missed rc1 and rc2, and it would be a
shame to miss rc3 too.

Do I have the right folks on the cc for this?

thanks
-john
