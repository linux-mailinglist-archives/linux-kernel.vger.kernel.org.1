Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2222E0CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgLVP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgLVP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:27:25 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51072C0613D3;
        Tue, 22 Dec 2020 07:26:45 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s26so32801117lfc.8;
        Tue, 22 Dec 2020 07:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GMr5VCPTqCz2ZfWhdjCVasC/tsHX8qwCEfhYsLYdAg=;
        b=pjBMMl7HgkRiFIGdJygUked00u2rRnsciWj9vSEfaT/mIpaxKhZufXxFk2vBRyY18S
         qJ5uX+ckghvmzYTJDp2IzlzaQ2szcafhnR3gQnlaeu6IrOzdztqIVa9OzjBwtRObvM9/
         qcDZ73SUtfEkc6UCCzA5al/d8cTdspT/HuZdxqJPwfeq2OHmrz3la33ZODuWkAzHpcRD
         7lGHfN+LcOaTRA1pIOGSMrPBdMCz0dWBE5ADWtB3u62zAQF5FuLUfYjjn+ymfs7LOaNv
         e5+RMSA6Kaf3RT5+50pHGKmQANRXGEZJ36FYs01w/7rMxKBmxAbb4ovJn+/RQKJVsoGi
         bECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GMr5VCPTqCz2ZfWhdjCVasC/tsHX8qwCEfhYsLYdAg=;
        b=HCv2s0r3qS9UGLY1q8/jN+ocZd4EbjKHJVvgp7zeoj+ywyzlUUu1SI/8w8+MiipftQ
         InEkJdcEH98HSFhWjrgUIJauVEkkEjZXwIZiFlQY/ztc8AX6wLuPkVWyPJeRKbbgdNWw
         KpcGuthwArcgJqvgs1rMbaKV68vrCw6M2pH1nDR+GY7cnrhSK/Zpm57/44jyFRp31gx7
         w2X/RaT50+8YfCmRlEtrTCU1m46Jmwy0yMSqknDX4pRhzB9+oAMdkGh87IxLuiOo8ffJ
         tJ72URG9F/zgbrLqAKEvQm4hG4N55LoTQP9CIqyMg43hajxrdL8wvE7ko1k8p2eb7VBV
         nQNA==
X-Gm-Message-State: AOAM533FMYX6TN9NT6v0YATS2HeEmZXY9RNHoBeffzfrK5qZzC5nVUhH
        TJmt/w9z2H9tJdUzNdLW7Px96KC9JTB7bb0HKQ==
X-Google-Smtp-Source: ABdhPJz537Kn4W1RrlvyWs6eRYuxgQbuy8tUZsNZm94P4bwr7Xj51Bl698w6GAPxN1is/kt4T7LI1NtskOJk2KmKP44=
X-Received: by 2002:a19:23d8:: with SMTP id j207mr9670559lfj.144.1608650803872;
 Tue, 22 Dec 2020 07:26:43 -0800 (PST)
MIME-Version: 1.0
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
 <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net> <CAEJqkgjFVBEDxCVB+P3CjirRkCZW1_6s18AgOKpe+6er3VShpA@mail.gmail.com>
 <20201222061630.GB76917@roeck-us.net>
In-Reply-To: <20201222061630.GB76917@roeck-us.net>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Tue, 22 Dec 2020 16:26:17 +0100
Message-ID: <CAEJqkggMJMKS5E2n26nvoCfq1tnokQG+WQi+WH4J7gNNz+0o5A@mail.gmail.com>
Subject: Re: k10temp: ZEN3 readings are broken
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 22. Dez. 2020 um 07:16 Uhr schrieb Guenter Roeck <linux@roeck-us.net>:
>
> On Tue, Dec 22, 2020 at 05:33:17AM +0100, Gabriel C wrote:
> [ ... ]
> > At least is what the weird amd_energy driver added and since is only supporting
> > fam 17h model 0x31 which is TR 3000 & SP3 Rome, I guess fam 19h 0x1 is
> > TR/SP3 ZEN3.
>
> The limited model support is because people nowadays are not willing to
> accept that reported values may not always be perfect ... and the reported
> energy for non-server parts is known to be not always perfect. Kind of an
> odd situation: If we support non-server parts, we have people complain
> that values are not perfect. If we only support server parts, we have
> people complain that only server parts are supported. For us, that is
> a lose-lose situation. I used to think that is is better to report
> _something_, but the (sometimes loud) complaints about lack of perfection
> teached me a lesson. So now my reaction is to drop support if I get
> complaints about lack of perfection.
>

I agree it is an odd situation with these modules, but having
something is better than nothing.
As for the amd_energy driver, yes it is off on some platforms by 2%-5%
or alike but without having
that support in the kernel, regardless of the module, we cannot ever
come to perfection or near it.

For both k10temp & amd_energy driver I suggest to not drop the support
 but add kernel modules
options disabled by default, much like a lot laptop platform drivers
have for different reasons.

The amd_energy driver could have some any_ryzen option which turned
off by default.
That way people may decide if they want to use it even when not 100%
perfect and can report
back on platforms the reporting is accurate.
Waiting for AMD to give us ID of what may be in their eyes accurate is
like waiting for pigs to fly.

The k10temp module much like the same, some experimental_voltage_report module
option will be fine for now, I think.

I'm also sure owner of AMD HW will help out optimizing and maintaining the code.

> Guenter

Best Regards,

Gabriel C.
