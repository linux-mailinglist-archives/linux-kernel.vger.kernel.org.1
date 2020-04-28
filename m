Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898DE1BBE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgD1MsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 08:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgD1MsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:48:11 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14AFC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:48:09 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m18so32273753otq.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIMUGicgwmIFtnYG9N3fQPjEXkbOpiDE/URudlFOW5s=;
        b=dUDumjdTIlGGpNmZYXHngArdwQWCCtin2qUEkmCJQtwAgVH3K5XgViZI81wZ44IjG7
         Zq9hacLuuX3LoskBpPXvwEKqsb+nyh8KlA22O07jpgEn9K3uC6ACaKAN8PKic/lPqIH3
         aGuwroFwfXlxdyxjbX0M5ZO8aNaVayipg4ovDBY1QrVdSeb7pZN8F9XkXds1YomIXvTY
         YmfpZJC7mu05HAL4WFjKaNy2UHPs3FQx9op/si0XAJd964b+EV57407V2UZmA/ay/P77
         xLf+QNzD7vJnw4QY7Rt6Ymk3pNiAJ9KUWkKYygNBJf6EbhdoOzp+JfBNNHOfuB1A5awb
         aYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIMUGicgwmIFtnYG9N3fQPjEXkbOpiDE/URudlFOW5s=;
        b=ckjUlGWAhFQaOy8GZ481QZzjrXlRu7TKHkSeR1v0rFVHCw9rhqQPyUK5XKN+9Ekrm9
         E5eyMBh1yZubMp+cRfP0+jC1o2vqyKRs4N8dg6ZbZtcuFW2xK3xMVLccOzO9T2siwGQt
         xs/87A/qU31zBvjYxojacEtmfIX08yGDWgainSAnWRJzyXRMCrzeO9q5+TwkL5CMO4U3
         078RgponVEU5i0GDLIndGmREvsl+CDQLPL0i/RkNm+QWkze0XSTTOCQcw1GbkIY8nRW8
         z11Id5DV86WL9f7swBFErG9MDAv4zeVmKNx0nrkshlOmIi9XSHtOJICRqukXqMB4a1TQ
         x5GQ==
X-Gm-Message-State: AGi0PuYONcLClZpUZzgi+gvcTxRtaahxrVrOQ6Mey20/EPkZwrOXs10H
        UHpIspYFL0jSP7oL/dwVDJhbfh7lYUBR1Q0T+o3vyw==
X-Google-Smtp-Source: APiQypJfEP180kCuws7+abjZcT8dPX9zxxKNlOozz0+TthkUItgt4+ccPZriFdCypuPgxcXtg9LpjV+6NqVW8gqrIFU=
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr22370151otq.66.1588078089294;
 Tue, 28 Apr 2020 05:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200401163542.83278-1-robert.marko@sartura.hr> <20200427164514.GQ56386@vkoul-mobl.Dlink>
In-Reply-To: <20200427164514.GQ56386@vkoul-mobl.Dlink>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 28 Apr 2020 14:47:58 +0200
Message-ID: <CA+HBbNHT7bOM68zBGAHO0Pi9WrBc244Qewwe5JV7fNhNUGPZ4Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] phy: add driver for Qualcomm IPQ40xx USB PHY
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 6:45 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> Hello Robert,
>
> On 01-04-20, 18:35, Robert Marko wrote:
>
> > +static int ipq4019_ss_phy_power_on(struct phy *_phy)
> > +{
> > +     struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
> > +
> > +     ipq4019_ss_phy_power_off(_phy);
> > +
> > +     reset_control_deassert(phy->por_rst);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct phy_ops ipq4019_usb_ss_phy_ops = {
> > +     .power_on       = ipq4019_ss_phy_power_on,
> > +     .power_off      = ipq4019_ss_phy_power_off,
> > +};
> > +
> > +static int ipq4019_hs_phy_power_off(struct phy *_phy)
> > +{
> > +     struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
> > +
> > +     reset_control_assert(phy->por_rst);
> > +     msleep(10);
>
> why not call ipq4019_ss_phy_power_off() here as well?
Its not necessary, SS and HS PHY-s are separated but share
the same register space.
So when HS PHY is controlled, SS PHY can remain working.
>
> > +
> > +     reset_control_assert(phy->srif_rst);
> > +     msleep(10);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ipq4019_hs_phy_power_on(struct phy *_phy)
> > +{
> > +     struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
> > +
> > +     ipq4019_hs_phy_power_off(_phy);
> > +
> > +     reset_control_deassert(phy->srif_rst);
> > +     msleep(10);
> > +
> > +     reset_control_deassert(phy->por_rst);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct phy_ops ipq4019_usb_hs_phy_ops = {
> > +     .power_on       = ipq4019_hs_phy_power_on,
> > +     .power_off      = ipq4019_hs_phy_power_off,
> > +};
>
> So this is fiddling with resets, what about phy configuration and
> calibration, who take care of that?
As as I understand, since I don't have documentation access is that no
calibration and configuration except to properly reset them are needed.
Development hardware required some magic register values to be
written but in the previous revisions of this driver it was
discovered that they were leftovers from the development HW.
>
> > +static int ipq4019_usb_phy_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct resource *res;
> > +     struct phy_provider *phy_provider;
> > +     struct ipq4019_usb_phy *phy;
> > +     const struct of_device_id *match;
> > +
> > +     match = of_match_device(ipq4019_usb_phy_of_match, &pdev->dev);
> > +     if (!match)
> > +             return -ENODEV;
>
> you are using this to get match-data few lines below, why not use
> of_device_get_match_data() and get the match->data which you are
> interested in?
Thanks, I will look into it.
>
> --
> ~Vinod
