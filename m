Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998962888C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbgJIMcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbgJIMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:32:09 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30849C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 05:32:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p13so9160549edi.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUAbjMn6Sut0uISHiyjGjXWIBOv9pWn68cRUr4CxFPM=;
        b=f7h/kzETGaS5zBqzSWJcxO6s5hCJX5BXgSuoHMHAey9T0xCo0j8AYyRmVVHfsD1qIf
         ztD2Yp6L5XZ6bZ4s2tmyTgoWyPPoun5osycIbDE3FELV599ngrvddehdpAL3zDHfmVlK
         P/t/TVvhz7OC1blo+MTpNouPsITkkNWWYYAlH/RURnpdQlam/ML3J+dsjQLYu1cYEdP1
         VDOIthMcwrEDR27e2Eq3nJKSsuoaqK1jNiVSbJhY0mDbZBx9kgZ/5wsk4RC2knPyi0yO
         5tHkM7YX/eUF9G5ht4jS6XG5IIqKnQZYc/r0t5jkYpwicaJ9Kar593+6gnqzsuwRTnBG
         Ggow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUAbjMn6Sut0uISHiyjGjXWIBOv9pWn68cRUr4CxFPM=;
        b=meY82WZWgqI19UVNmI6c7OdpRG0InpsZneuqijFxWL7ovo7EvRXD35hxVNhmWgF12w
         y5MSLFsfO77AV/1g4G730Izy/ddJ0wZh61IO2XAewjEJDd+36rBH0EuCaCfl167Cry48
         nN8fm+25teuLcpuu2jhd8a4ych0vkEgPUU36x1MBX9Tct/UKnIwvcy9yrmUhV4oGyh5W
         8Uvud91qoZu7vNGZBQ0g/lCutD705LNCumhtZ6JfPsjfj4DdA5m40Ft8muZ383OAqVT9
         SOzCwd+6qTZA5xNl3BQ6o1twANmYWnBbH76roOPXFxhTnJIw4eCb1U0MEd3CXQSR0VlN
         eS+A==
X-Gm-Message-State: AOAM531jsNjfH5898RrIlYBkL7qA5QmERPFTtu1hkX+BTrRElDylPnlm
        +5s2VLUtb0vqCvK3a0pUjxJT0BQfaWJc+Y5yQJo2Ig==
X-Google-Smtp-Source: ABdhPJwYSrZ+CzqVVz99nKlIiE7vDVGh/FhhEkpLZbwNdhLii/I7iM0+BuCzhB7Uv1iF2xL6gHicRlF06mGTl2E6dXU=
X-Received: by 2002:aa7:de97:: with SMTP id j23mr14371489edv.45.1602246727830;
 Fri, 09 Oct 2020 05:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143722.21888-1-etienne.carriere@linaro.org> <20201008191727.ht26r5dnh3iwqj5n@bogus>
In-Reply-To: <20201008191727.ht26r5dnh3iwqj5n@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 9 Oct 2020 14:31:55 +0200
Message-ID: <CAN5uoS9YffDZa6YOnJ_35ueMbkvCPuQ1=0KAuX5=k=kQYm+_Ng@mail.gmail.com>
Subject: Re: [PATCH 1/5] firmware: arm_scmi: always initialize protocols
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

On Thu, 8 Oct 2020 at 21:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 08, 2020 at 04:37:18PM +0200, Etienne Carriere wrote:
> > Remove the IDR replacement that prevent initializing an SCMI protocol
> > when it has already been initialized. This is needed when there are
> > several SCMI agents that do implement a given SCMI protocol unless
> > what only the related SCMI protocol communication is initialized only
> > for first probed agent.
> >
>
> Can you please elaborate on your usecase please. What do you mean by several
> SCMI agents here. OSPM is the only agent we are interested here. What
> other agents is this driver supposed to handle here. We allocate memory
> in init and calling init multiple times messes up the allocated and
> initialised structures.
>
> So NACK for this patch as it needs more work if we need this at all.
>

Hello Sudeep,

Considering a device with several SCMI servers spread over several co-processor
and possibly also in the Arm TZ secure world, each of these servers
uses a specific
SCMI channel. Without this change, each SCMI protocol gets initialized
only for the
first agent device that is probed.

My setup is also a bit specific. My device has several secure configuration
features that can individually be enabled or not. For example, configuring
domain X as secure makes some clocks reachable by Linux only through SCMI,
and configuring domain Y as secure makes other clocks reachable by Linux
only through SCMI. For flexibility, I expose domain X resources (here clocks)
to an Linux agent whereas domain Y resources (here clocks also) are
exposed to another agent, each agent with its specific transport/channel.
Enabling each agent node in the Linux FDT allows to define which SCMI clocks
get exposed and hence registered in the kernel.
Without the change proposed here, I cannot get the clocks exposed to both
agents when enabled as the SCMI clock protocol is initialized only for the 1st
probbed agent device.

Regards,
Etienne

> --
> Regards,
> Sudeep
