Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2919DDB5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404482AbgDCSQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 14:16:36 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36036 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:16:35 -0400
Received: by mail-pj1-f65.google.com with SMTP id nu11so3300944pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l9OtO5bBjU4ri0ecYRkCgiryeyjL/1OJpZNChQ7ItYI=;
        b=NYx+sHPEuWXImveqC5saq7LPSHEW29HyBJwPIy0Wsv4qxJp8hwJZwCQLBGUxkDoz5n
         NRTdcePZ89Ihj3Nr1q4SSWTYE9L6ixXMinliK5sCArFNnBmm0cTAjVAVEUR491pc7zx+
         7TWCe9R7nyZui0z+kqVrFdlu5SedTFb/AKFV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9OtO5bBjU4ri0ecYRkCgiryeyjL/1OJpZNChQ7ItYI=;
        b=XuJhJLCGRBY727yu0knSPelOwMlsbFbO1w1kByIjDG499cKZWXkBuAQtZyiQNm4zch
         DlPLwID+lGKhRYdl/jL0X/WnoShi0eo5WD9oRsi5Kzt76ZvWeCA+rL4dTkcnbi5Me3Lx
         een9ImmYhXgMrNuIDVhjqiZZvqmGdJTDzncsqrwlNbwWNJffl0zGNu6rryFA2PxzLJhI
         8B+ak3MnvBDTGiTh3bQfwgs7etFWCKNo1wyliFY/RNvyYA4A26D1mcpULl6OWnTKFlH8
         EFFxOukEfB8CMikmEV00bAAwJHQQRYHfF2Uke/8O5FUULVpPct4GQBd9NKRVajqhLX5a
         Tb+Q==
X-Gm-Message-State: AGi0Pua70UVZa8O/OC2SugO9fOIQkeVAoc1iyhjzhdovmcBAvW7XzZCh
        n7hahlmzlg3l3a76Sefw7HqVlQ==
X-Google-Smtp-Source: APiQypIGHcLKfA4BC6dhIJebo6CEcV70oa/S4T2XWdYpRNyxtEt21rnfykH5/137XQhZwQNCpuZxdQ==
X-Received: by 2002:a17:902:d3cb:: with SMTP id w11mr8949903plb.257.1585937792655;
        Fri, 03 Apr 2020 11:16:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x3sm6250986pfp.167.2020.04.03.11.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 11:16:30 -0700 (PDT)
Date:   Fri, 3 Apr 2020 11:16:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rajeshwari Ravindra Kamble (Temp)" <rkambl@codeaurora.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Doug Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        sivaa@codeaurora.org, Sandeep Maheswaram <sanm@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Changed polling-delay in
 Thermal-zones node
Message-ID: <20200403181629.GP199755@google.com>
References: <1584430804-8343-1-git-send-email-rkambl@codeaurora.org>
 <CAD=FV=VLZ4RQQuji=1kKE5EnqrpY0M=U_G8XigAWAaZ8mxc=eg@mail.gmail.com>
 <fc7f250e-aa85-0835-8bc4-8274235c74d0@codeaurora.org>
 <CAHLCerMCrNdKUmRww4EFctU8cojh6Fqhs7gpux3SNCSwYUBOvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHLCerMCrNdKUmRww4EFctU8cojh6Fqhs7gpux3SNCSwYUBOvQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajeshwari,

do you plan to send v2 with an updated commit message?

Thanks

Matthias

On Wed, Mar 18, 2020 at 02:40:47PM +0530, Amit Kucheria wrote:
> On Wed, Mar 18, 2020 at 11:49 AM Rajeshwari Ravindra Kamble (Temp)
> <rkambl@codeaurora.org> wrote:
> >
> >
> > On 3/17/2020 10:20 PM, Doug Anderson wrote:
> >
> > Hi,
> >
> > On Tue, Mar 17, 2020 at 12:42 AM Rajeshwari <rkambl@codeaurora.org> wrote:
> >
> > Changed polling-delay and polling-delay-passive to zero as per
> > the requirement.
> >
> > Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 100 +++++++++++++++++------------------
> >  1 file changed, 50 insertions(+), 50 deletions(-)
> >
> > It probably wouldn't hurt to mention in the commit message that this
> > is because the thermal sensor interrupts are all hooked up and thus
> > the polling is not a useful thing to do.  ...but other than that:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> >
> > Hi Douglas
> >
> > I didn't  get your comment.
> >
> > Thanks,
> > Rajeshwari
> 
> I think he means that you haven't mentioned WHY this patch is needed
> in the message. The reason you should mention is "to disable polling
> mode of the framework since interrupts for tsens are already
> configured."
> 
> Regards,
> Amit
