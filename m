Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30B42888D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbgJIMeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733205AbgJIMdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:33:54 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 05:33:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l16so9171163eds.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh2n7JTOlnh8jp4YVILpBkjU8VUOmwjOIzqoK1zdP0U=;
        b=SA4HQvgy7dVbJlrGJoRSjQQnctTiEs6lxNiCVgQLdveKjsV2Z3ZUq/gUG5z3/1DQA2
         WdevfZyBpFYqlQjYDfA2NGj/RWvlKXZB/gjXWgYHAQGuB9ULD4zVKHqatnmi527YlPBY
         EmARUoB9uPNa/XVakPtnh2tCqf7g3kzXMH4ZYgcY6k4Cad9uzOpCjMGq39ujEcyLulb6
         PNgst/rjOI1jFwUKJY6L209ruPNsr6+EVmJSwXw2Tc0dw11miAQ9sh3UsssOUUk0Q6Pl
         d07N4JWOXWl4LZt1tsaZnPZ2LjKEqNtdzWI7h2Xc5PoiYlAPGzsDfqyU1bk2R3HSuNtI
         WDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh2n7JTOlnh8jp4YVILpBkjU8VUOmwjOIzqoK1zdP0U=;
        b=rH+Jlgar9leSy4C0pwBlGAS+Jnkk9ybgP/qrAFi+s21/f9mg+AMY1PM+UhuuCcvCtM
         EBVQJ772hUNSIP52e27qE/+hH/Z9L3UEdoh10XwAjDVYFTDgN9+haU3ifZaoKUJL15VA
         8shu6yoJlWh72H9x4nZyAKct/tpwLAI1upINZZXc2MWhfU9UaAzfQVNcBU5qX6YOAdbb
         /ditDdA6KsQZCUgrrL91FLIorRTAxTvo5LOMy55Tu+kwO+gNwNpxYdsEN/NKMzV0NZfs
         d7o5Vrksj4FCRnwcmyr11DeHdd0nRM8CfGuX0M/XRYxDooAZG6zYagV7IF5uk3ievY3f
         ItLQ==
X-Gm-Message-State: AOAM531G2djfWnirEFOy3oMY+GDgWTcoYWpjWN2r3OV+CRL6IOw/RD33
        btAJFOcx9AL+0iSe46qLhgp51UofKOdEhSyufeByykBjywit3app
X-Google-Smtp-Source: ABdhPJxqYTi7SdDhXmLiWxET3NR/Jr9aIaUP5DHddg4xb+OeAkHZJ/UeqSpHoGyYChnU4q3d5Be8e5g8gkO1xq7G3+A=
X-Received: by 2002:aa7:d2d5:: with SMTP id k21mr13646090edr.62.1602246832731;
 Fri, 09 Oct 2020 05:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-3-etienne.carriere@linaro.org> <20201008210839.6nnl2tvm2re2ckvu@bogus>
In-Reply-To: <20201008210839.6nnl2tvm2re2ckvu@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 9 Oct 2020 14:33:41 +0200
Message-ID: <CAN5uoS-t2De5OvawUSeK1NuskqpBEt-rWGVtJky-E=+RRpe+_Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] firmware: arm_scmi: add config dependency for smc transport
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020 at 23:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 08, 2020 at 04:37:20PM +0200, Etienne Carriere wrote:
> > Fix dependencies for configuration switch ARM_SCMI_PROTOCOL that
> > is not exclusively dependent on MAILBOX since the alternate
> > smc transport that is depends on HAVE_ARM_SMCCC_DISCOVERY since [1].
> >
>
> Do you need any build issues ? I don't see why this is needed.
>

This change is for consistency of the kernel configuration.
Without this change, a kernel configured without CONFIG_MAILBOX
cannot embed SCMI support even is using only the SMC transport
enabled thanks to HAVE_ARM_SMCCC_DISCOVERY.

Regards,
Etienne

> --
> Regards,
> Sudeep
