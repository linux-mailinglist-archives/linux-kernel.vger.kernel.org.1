Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1372964B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369704AbgJVSbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369326AbgJVSbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:31:41 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850A9C0613CE;
        Thu, 22 Oct 2020 11:31:41 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j8so2645617ilk.0;
        Thu, 22 Oct 2020 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tclO6iWsKMS0iQgtui86k6EcK3JiEJEq+CF6ReqqBP0=;
        b=f0ed5Wsn6FuyNQPVhMCZAk+NxRiU/Dp+c+mjzUxc9yHQDfaFF0hOOzjsjrTtiCXA8V
         lWvrTuBfnEjdC4QvAnQAeNfEjiIPijv1fTzIsfd+QOPUvZEGGJW78jvse8KbfEkbNcFi
         Udn5os+30NfWu29ukdpqqJZA9oq3aLyKckQZukCrD9xDi5hH4fAhi3NjvrmEoQKShjpu
         h4X6oLArPw4QA7XVBagUfiqD7JBJFOQ8nopuizjaaZeO467qM1yZeSoP3zwrq1VdpVH4
         pDSJMagOCVGEZquKaETKXSF5Vm3xlwFZ39GF7WMRtFnXjLo9OfLVolM246Ixg7z92uQA
         jGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tclO6iWsKMS0iQgtui86k6EcK3JiEJEq+CF6ReqqBP0=;
        b=g8v6ehWe/NvZKrqtw0+cQ+CwJBlsbppfG3MPaz1PyA6kNWsLW0madxxNDFqyUv8Hsp
         AMLnDwYBUlS6cPqBSiF+VFszhWoUK2olfTBNUTQfCQQWoGdkiPCfR2vgz6EbPO+U7uwe
         dfhmOdZ2wXJd+fEcuC/TfUvYY1j0qFRRd+tkHzdCfx+K0OgC9SIDEtBfqlwoTLwFT5un
         JAcddFva70IKYYj5GtaeCQeZotMyMu3qrUrHNyNpjRHuidCV474r7yonH7MqmWebL1Kc
         2c5JNRxOs/FBLgTt5gdT1qz6uIHqvQfp/3/xhTdZ+bE5UpX+8mmwHO8DUkD6/YYQttQt
         r7PQ==
X-Gm-Message-State: AOAM5330Aghi8z1UG9q+nSybYb9htVUK3EfdS93YJZcwyS9tCKYbikQA
        +wtRF0AGxE34mAa8fk7PdnBOJQ0tpE0iYDY+mfI=
X-Google-Smtp-Source: ABdhPJzKNFfW+WWsjG+rfN4KqSYnV2UsIOV1hbgv5WbaPwUV1x3VYG7uISprBk2hKa+t11V47HWYVCPscWVboqS7e3I=
X-Received: by 2002:a05:6e02:52c:: with SMTP id h12mr2817480ils.196.1603391500640;
 Thu, 22 Oct 2020 11:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201022171639.773702-1-aford173@gmail.com> <5d17f3de-6864-c8fb-6413-24de943df1fd@denx.de>
In-Reply-To: <5d17f3de-6864-c8fb-6413-24de943df1fd@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 22 Oct 2020 13:31:29 -0500
Message-ID: <CAHCN7x+66Ziza0G2Q6iho9z3RKsiw9=PyqoCayXCXyAONcDLow@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add GPU node
To:     Marek Vasut <marex@denx.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 1:17 PM Marek Vasut <marex@denx.de> wrote:
>
> On 10/22/20 7:16 PM, Adam Ford wrote:
> > According to the documentation from NXP, the i.MX8M Nano has a
> > Vivante GC7000 Ultra Lite as its GPU core.
> >
> > With this patch, the Etnaviv driver presents the GPU as:
> >    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> >
> > It uses the GPCV2 controller to enable the power domain for the GPU.
>
> Subject should say 8mn , not 8mm .

ugh.. My mistake.  I'll submit a V2 once other have had a chance to
give some feedback.

Maybe NXP can comment on the dialog below.

>
> Are the assigned-clock-rates correct ?

I used the assigned clock rates from the vendor kernel, with the
exception of running at 400MHz instead of 600MHz.  According to the
datasheet, the GPU clock needs to be 400MHZ to run at 0.85V. The
600MHz operating point for the GPU requires a 0.95V operating point.
Since the default operating point for the Nano shows 0.85V, I left the
GPU clock lower to match the normal operating speed.  This varies a
bit from the vendor kernel, but their kernel is also showing a 0.95V
operating point, so I think that's why they are specifying a 600MHz
operating point.

On the Beacon embedded board, we're driving the LPDDR to 800MHz which
requires the ARM to run at .95V.   I was able to override the
assigned-clock rates for my board to run at 600MHz, and change the ARM
operating point to .95V to meet the spec.

My intent was to use the defaults and let the board files override
them.   If you want, I can try to look through the board files to see
what operating point their using and propose updates to those
respective device trees to address the clocks on those boards.

adam
