Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BCA287D84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgJHUy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJHUyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:54:25 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F0C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 13:54:25 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b22so8109059lfs.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tocO/B9Lq6+1kVJFUNhSCxjxnRpjafNIdcN4JRNBVbc=;
        b=YoiXBLYaxbs0qCVBRDnMH27sFMKBPT5ra2QPLTUzuzpkCRDid+wTU6iVsny55UyX+z
         ZSwVBRBUgbSb+p2PA7gjjgwvp42yXzz7v/C5ADQpzZveA7GHjZtKBaRQttK/Q2RZNYy5
         aJ15KMFFzwBqNJzmYvat5bZCmRhbrfkFDl+PB6T+MWyKEh3k1JL0mBRnMfAkRNnmKWZ0
         CAXplWyqxfYga8bbMW54N/Um8CEACrqaH2k1qvUc70gGyhXOgZmgo1uflLsUJVzbSNH9
         Jl+HukaQt0GcYCsSxUq30pCijnPFjCZzqiavpJge8g6AIxRSxYz7XxX2dJJdHC/2xqgn
         WNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tocO/B9Lq6+1kVJFUNhSCxjxnRpjafNIdcN4JRNBVbc=;
        b=YKqra9fOwpf6DvHC8GINZTfFUS4sLWKXg7pjPIq3fh4oxz1OzHQr7og+4pM5z786Qu
         U2zpCIPJ28tQotNJ4cNP5eUBAPHF838Cd3LOhtl3NDNXp235C4bZnG9QgWG1hm0fX7qt
         R/xTbelu0DLyrfm+qfa1ahxa2WdODU2Shw0lDZUcc1iE6D0YJxnPE4uk1ZagZMQw4Qr5
         Cp3vMx4YGElVOee1ef2Rc3aqmliGQyFScua/uMLpZQTrSnAR8HpsAByA7Y+qGBYmSIl+
         wIrwLHmpPtzvc22O+DwKh9Mt2nrUifLmoZuQFbTK0jGp20eUKMDjgmF7ZyRZ3kyXGA3m
         GSZg==
X-Gm-Message-State: AOAM5339bpwC6kF0hnf3vk6HSv4FUP60sRDmYlO6r4vZ8bIamt3AV+8w
        0iCg7v6Xgp3vU5mhx4j7JoKQitgAb0QkdgrDq/xZq7fiBDP59A==
X-Google-Smtp-Source: ABdhPJxcWRYqQbXfXwqugkMw/o/Tb2QvJ1KChfARrTOjotSF8GKqXHAadrzMf4OTQL6OgJgT6Np7m8icj77pU9yHJo8=
X-Received: by 2002:a19:824f:: with SMTP id e76mr1878046lfd.572.1602190463699;
 Thu, 08 Oct 2020 13:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201005160614.3749-1-ben.levinsky@xilinx.com>
 <20201005160614.3749-5-ben.levinsky@xilinx.com> <CACRpkdb1x=U28VWZGDJh6gJSzaqeNxx0m+WtnUQZJKGvXjvXYQ@mail.gmail.com>
 <BYAPR02MB4407F9D8A60519D00F317D27B50B0@BYAPR02MB4407.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB4407F9D8A60519D00F317D27B50B0@BYAPR02MB4407.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Oct 2020 22:54:12 +0200
Message-ID: <CACRpkdb2AamnF9h_FfFDhTBMz7W-gob98OOzrHOiovyoiBPWRw@mail.gmail.com>
Subject: Re: [PATCH v18 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
To:     Ben Levinsky <BLEVINSK@xilinx.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "Ed T. Mooring" <emooring@xilinx.com>,
        "sunnyliangjy@gmail.com" <sunnyliangjy@gmail.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Michal Simek <michals@xilinx.com>,
        "michael.auchter@ni.com" <michael.auchter@ni.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 4:21 PM Ben Levinsky <BLEVINSK@xilinx.com> wrote:

> As you said, this is  just regular ARM TCM memory (as seen by the main AR=
M64 cluster).
> Yes I can add back the compatible string, though maybe just "tcm" or "xln=
x,tcm"

I mean that if it is an ARM standard feature it should be prefixed "arm,"

> That being said, we can change this around to couple the TCM bank nodes i=
nto the R5 as we have In our present, internal implementation at
> - https://github.com/Xilinx/linux-xlnx/blob/master/Documentation/devicetr=
ee/bindings/remoteproc/xilinx%2Czynqmp-r5-remoteproc.txt
> - https://github.com/Xilinx/linux-xlnx/blob/master/drivers/remoteproc/zyn=
qmp_r5_remoteproc.c
> the TCM nodes are coupled in the R5 but after some previous review on thi=
s list, it was moved to have the TCM nodes decoupled from the R5 node
>
> I am not sure what you mean on the Arm64 handling of TCM memory. Via the =
architecture of the SoC https://www.xilinx.com/support/documentation/user_g=
uides/ug1085-zynq-ultrascale-trm.pdf I know that the A53 cluster can see th=
e absolute addresses of the R5 cluster so the translation is *I think* done=
 as you describe with the CP15 instructions you listed.

It seems like the TCM memories are von Neumann type (either can
contain both code and
data) which removes one of my worries. According to this data sheet
they are also nothing
ARM-provided but a Xilinx invention, and just happen to be hardcoded
at the same address
as TCM memories in ARM32, what a coincidence.

So I take it this is the correct view and you can proceed like this,
sorry for the fuzz.

Yours,
Linus Walleij
