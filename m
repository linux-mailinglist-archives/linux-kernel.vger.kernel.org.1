Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9582837F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgJEOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgJEOi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:38:27 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3720020776;
        Mon,  5 Oct 2020 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601908707;
        bh=qrpsw39g2HYMqSB+6zkRrrlQVSk8tcTuR+W4i5vTgiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yCseW3CGhvBD1u87duDf4tOl/uBzHVb2eh2lLEi20G9+2nmUBe069o/Pe48dOc+Cr
         TvCl+L76nwScIzXqYdtVOG2Wb56Ww92oEwSxQkvMfkWmjW6M2UUngpgELG7qcWj0o6
         cCoXV8T/G/CPb6phUgcN1rGn1do0LHbUwCTFtfow=
Received: by mail-ot1-f53.google.com with SMTP id i12so2989670ota.5;
        Mon, 05 Oct 2020 07:38:27 -0700 (PDT)
X-Gm-Message-State: AOAM530fgUS/XqNw54GFDzYAnms59p47NiD5v8USdrFRPeHvhdRyMju6
        g3ZXb2V+vikyZCbxr0/c5Ze13/gAHL1NNNABbA==
X-Google-Smtp-Source: ABdhPJxgzGZnVxNKnaUW4PGBqPAxCXhLxf/zBWeYtpXei81FHb/CaZ0SrtW1AZcxDxTzUg+Sq6ioaWDXnTPhY5ZUsRY=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr12169390otp.129.1601908706622;
 Mon, 05 Oct 2020 07:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201001145738.17326-1-alban.bedel@aerq.com> <20201001145738.17326-3-alban.bedel@aerq.com>
 <9c164930-ffec-415e-caf7-4eb8c2e57576@roeck-us.net>
In-Reply-To: <9c164930-ffec-415e-caf7-4eb8c2e57576@roeck-us.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Oct 2020 09:38:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJa82AYJQHfxNweJBzL7rLq5Tnzr7fW87SeifwtWkAWCA@mail.gmail.com>
Message-ID: <CAL_JsqJa82AYJQHfxNweJBzL7rLq5Tnzr7fW87SeifwtWkAWCA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: hwmon: Add the +vs supply to the lm75 bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alban Bedel <alban.bedel@aerq.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:08 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On 10/1/20 7:57 AM, Alban Bedel wrote:
> > Some boards might have a regulator that control the +VS supply, add it
> > to the bindings.
> >
> > Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> > Acked-by: Rob Herring <robh@kernel.org>
>
> I have nothing in my records, and nothing in patchwork, that suggests
> that Rob gave this patch an Acked-by:. Please point me to the respective
> e-mail.

I did on v2.

> Patch 1/3 is also missing an Acked-by: or Reviewed-by: from a DT
> maintainer.

In my queue.

Rob
