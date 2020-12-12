Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172612D83BF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 02:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406221AbgLLBQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 20:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406039AbgLLBQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 20:16:52 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A96C061794
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 17:16:11 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id p14so1258305qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 17:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5z8mvBAx6elWQI5gnf6juSwCe7Q6khLHeqQo51k7QA=;
        b=RSFvsIm2zT03xssBCGEy4GXK/F1DrSWXiR+JudZ25DcmMM/3MmWFKLbel8ufV4CO26
         3zAhTGLQvHa+RBWH0023T1ew4xzI/ZgTgDqR9iksa7irOrkdHhqe6AQ9eeGO0SYVjN1S
         kevPj2qix/pC23gGJlY9xlHiU9es0iiSxnNKCwSiEry3LacZ3PdfZKMtaAtQFdDxJL5X
         sDW7MDrUYLuKqdSvICFybS2VGOIoZzxRjWODoEcLXaU65psxiaG+e2F98Jm0Ssq1ATnB
         0Ox41pQl+eahmpgIkWiOqErhIPE4w7wWnyEeCtfobscd6FaU/innwYiv4HGR4o70ZDD1
         3gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5z8mvBAx6elWQI5gnf6juSwCe7Q6khLHeqQo51k7QA=;
        b=rf3hjIlSrUxh+I1pmKEAEtyCyKJ/yMv2FQnXvKkE47ElOF9/VgxIppoa7EfAQgmBlf
         e6+QzM4quixgeUOhs5erhi0QUM7POC6pZ8/hs/qNxwKZf7e6qDbr8H5vi2asV0PcZFFM
         SKl7znFtzhW+18JUucHjodha+guwHkY1inaUKNXBcTft6RlsNf1TnzRzs+P6++CTapMO
         gmpfKi8LhAIyXXRGMJJoqr/GN5cgS8lDBjlCVLzCuVEZ5GNG1+hXBcTaf6PzHrenJo8v
         4HUi1xPSIhJJQVIwsyeJ5nkrZJ2h0PhPA1tL+Nd0FDm+yb4Oh64ry1aF7aNBovVuqkeW
         OBsg==
X-Gm-Message-State: AOAM530rJrueA6a+gu9pNMTNF0vj3ZWDa/1jFcbQpplJsXNfk9OcUqCg
        bGcPvv++lj6QYgVrBjZaZflECdrnFlFRjxPD0Gzn5w==
X-Google-Smtp-Source: ABdhPJyBX8VZzIGct7rN4I1OFl0hIIZOGg06Cx5/owhyNKbpS2JJB272GG0JoEhHQXKnGyEEyIfiZjk17F9DWAf6kAE=
X-Received: by 2002:a37:b982:: with SMTP id j124mr20389158qkf.1.1607735770821;
 Fri, 11 Dec 2020 17:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20201211215427.3281681-1-kunyi@google.com> <20201211215427.3281681-4-kunyi@google.com>
 <116ca29a-8270-9b03-520e-bc3ffcf43552@roeck-us.net>
In-Reply-To: <116ca29a-8270-9b03-520e-bc3ffcf43552@roeck-us.net>
From:   Kun Yi <kunyi@google.com>
Date:   Fri, 11 Dec 2020 17:15:44 -0800
Message-ID: <CAGMNF6V_4B5QrW8+oEvivvTBSM4_LRo24AVirXfMvmJY9zw-rA@mail.gmail.com>
Subject: Re: [PATCH linux hwmon-next v5 3/3] dt-bindings: (hwmon/sbtsi_tmep)
 Add SB-TSI hwmon driver bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        "Venkatesh, Supreeth" <supreeth.venkatesh@amd.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 3:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/11/20 1:54 PM, Kun Yi wrote:
> > Document device tree bindings for AMD SB-TSI emulated temperature
> > sensor.
> >
> > Signed-off-by: Kun Yi <kunyi@google.com>
>
> Any reason for dropping Rob's Reviewed-by: tag ?
>
> Guenter

Sorry that was unintentional.

>
> > ---
> >  .../devicetree/bindings/hwmon/amd,sbtsi.yaml  | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml b/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> > new file mode 100644
> > index 000000000000..446b09f1ce94
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/amd,sbtsi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: >
> > +  Sideband interface Temperature Sensor Interface (SB-TSI) compliant
> > +  AMD SoC temperature device
> > +
> > +maintainers:
> > +  - Kun Yi <kunyi@google.com>
> > +  - Supreeth Venkatesh <supreeth.venkatesh@amd.com>
> > +
> > +description: |
> > +  SB Temperature Sensor Interface (SB-TSI) is an SMBus compatible
> > +  interface that reports AMD SoC's Ttcl (normalized temperature),
> > +  and resembles a typical 8-pin remote temperature sensor's I2C interface
> > +  to BMC. The emulated thermal sensor can report temperatures in increments
> > +  of 0.125 degrees, ranging from 0 to 255.875.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - amd,sbtsi
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: |
> > +      I2C bus address of the device as specified in Section 6.3.1 of the
> > +      SoC register reference. The SB-TSI address is normally 98h for socket
> > +      0 and 90h for socket 1, but it could vary based on hardware address
> > +      select pins.
> > +      \[open source SoC register reference\]
> > +        https://www.amd.com/system/files/TechDocs/56255_OSRR.pdf
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        sbtsi@4c {
> > +                compatible = "amd,sbtsi";
> > +                reg = <0x4c>;
> > +        };
> > +    };
> > +...
> >
>


-- 
Regards,
Kun
