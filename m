Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE9E287B40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgJHRzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgJHRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:55:17 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C504CC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:55:17 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id x26so2142978uan.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNQQ8Pzu8RQQ0ORGYkymPkG1Mv2Qdb50Y107jo7+z4k=;
        b=UHXJxnRrqcCyUKjKCYUzXTkrzHXeon0tY5OSJKwEjDrS+2TMWgRDZOizlJqVv6DmVB
         otgnTfPmmXND64V4bQgxJWF149sPI+O86ToB8bEX8xZ3Z4jIyHRDqTb+vTaO8Mrknn3V
         Wkg662TuZZGrga+S4PLlOCEGEh0/Au+I9I/KihvPbOkev+lbVw0JTFZMlDpcsNhveD02
         VEf224Pz+NPz4I6y2ZcheKdTdAjfqyX44YzIScZsAVx6o9wEAo5lX/MwQV8LD5GYCXaX
         K6oqghjFssc1H/uytsE6b1bLptK29lxwI4LuGhEbTlVC0Iscnhpip0J8xyDeIt75QBoD
         FhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNQQ8Pzu8RQQ0ORGYkymPkG1Mv2Qdb50Y107jo7+z4k=;
        b=MLhl+LCma1jjY+I+R1NNH1SWhgRF9z3q44ww7Sc4Bo8iyS4BXLGxvSjSy3+Y9s6hmJ
         RoMtcwDILxT6Qh5DvpiInjc2AkXv1ACyHqfIZigqZSL2VFb29sISJcd/hezr2RDe3G/V
         7q++AtIW+T8Up3ebdSvM3mGFCKCtq1UWyDrSM4vhZpnwP2Re++gEdF/Bc9nxEn4mQBbl
         0mN4SAr7tPL5gP5W9xx4gAqhdtwMA2tUiqlIM3untwnU4voVg9er6MuXZCdKbKavRvW0
         JtndG/T6qr77c1MnEA7W6SecQWwqPZl2oOlqy6OhDJg5+wPxEn9+fbjbyrgvLi3tw2U5
         ISjg==
X-Gm-Message-State: AOAM530ZvOhK1eWZbyRhR3OSaYbD7UYa1O3Rt1yp9Z2e3+MsGosHjzIv
        p6F+dOMiaws6ahF6lXC6Y80hSFeuyndIDeIuRj7JQQ==
X-Google-Smtp-Source: ABdhPJzHy4oNsragukowLXjjDBDA85BFdePhpnj4m1jPHyYF9KCFeJ9AIvHl8MqHlPc5VxnQL2lFhzmC075sEGzdz4c=
X-Received: by 2002:ab0:768:: with SMTP id h95mr5325071uah.23.1602179716700;
 Thu, 08 Oct 2020 10:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com> <20201008074600.GA247486@kroah.com>
In-Reply-To: <20201008074600.GA247486@kroah.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 8 Oct 2020 10:54:40 -0700
Message-ID: <CAPTae5KtMfXoOmqB-gRtLn4DqMHpqwesfR6OvE90akyv3irnjg@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] TCPM support for FRS and AutoDischarge Disconnect
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg !

On Thu, Oct 8, 2020 at 12:45 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 07, 2020 at 11:15:41PM -0700, Badhri Jagan Sridharan wrote:
> > Hi,
> >
> > Made two changes:
> >
> > 1. Added "additionalProperties: false" as suggested by Rob Herring in
> > https://lore.kernel.org/linux-usb/20201005144618.GA154206@bogus/
> >
> > 2. Removed FRS dts binding constants to address Rob Herring's comment in
> > https://lore.kernel.org/linux-usb/20201006182940.GA2574941@bogus/
>
> That worked better.  I've applied the patches that Heikki had reviewed
> to my usb-testing branch now.
>
> thanks,
>
> greg k-h
