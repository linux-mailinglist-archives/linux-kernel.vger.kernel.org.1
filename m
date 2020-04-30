Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56591BEDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 03:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgD3Byb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 21:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgD3Byb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:54:31 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8540C035494;
        Wed, 29 Apr 2020 18:54:30 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so3398028lfc.5;
        Wed, 29 Apr 2020 18:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6IdL3BAcEz7abiV3g4YHEMCO9WXnls6KQ2pdHBxgwww=;
        b=vB4VPh0Syzb1zOX3vCVy9aTmDEvNRDG4JWKAOCurlhM2NNg1xvtsdEt8WjAiN2CVu5
         cgIpLkOscWzQT222s35toq3cpsLZk5HaLa0INMlT8gRS74V9HQhQbrFt5Fmy1YTbmRac
         RLG3pk6JIWjpVcTKCGBS7O13XX5GwqFVtbSthQKNPxBMNdMz5p1qTbuxmKLyXa6I7nJ8
         fBJdvkQO79G7Li/YpzsCygEapfpxxsnMh2q6AslCabuBSQal5qqkUTAS4efcFb0Nvsni
         I6wTJF6uCKkiuEjwF8+1wLqhXTY9A7v7poWjpgwx8y1xs1t5ZRsm/0iLhUiI5/SISr4C
         yIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6IdL3BAcEz7abiV3g4YHEMCO9WXnls6KQ2pdHBxgwww=;
        b=gs3NhhOmB+AR1EG9G2MpLRpUF32cSrErxbsxbZ+Bmq8xBatWEnyuFLQHcxGpzZRn51
         Xl+UxFdSoYZN4kKMMq5Ux+YfFpj7TK7a8Q4oZxUIcGHtY8KUEv4o0Wm1ZfiHWvfbhMun
         Pqesip0w4G2/YUOeguHU6yxi2qnW/O6+K+SymkvQKkAmfF6l5Q30eWFZY8lIYpGSVn+C
         VEqJla7vZP4Am82w+zJ5+HVjEdhsARXXKOKEfmvjynAnSv9MuxZtAKtM8hbt2zPnYbWp
         En1FKmzMj32x7wPQKAb/Tn8AOgKa6UK10q3HaR0mK9sP3DK6abwoBfgh25HpShurKoZC
         OnJA==
X-Gm-Message-State: AGi0Pua1p2t4fgR5UgaOUev+By6yOwpFYadv+4IaW54r/+nYE2dvRwmU
        HP8Rbo9DP68unyre8KFeOT2fckE2
X-Google-Smtp-Source: APiQypIBbHrp4/2F2tJ4OpI6yrP0A2W2YCxYGDZG8ts8NryaGS4elN+6cmeSxBdo5jMf7GZu8d1axQ==
X-Received: by 2002:ac2:505a:: with SMTP id a26mr127711lfm.177.1588211669250;
        Wed, 29 Apr 2020 18:54:29 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x24sm3215886lji.52.2020.04.29.18.54.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 18:54:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH 0/6] arm64: dts: meson-gx: add initial playback support
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20200421163935.775935-1-jbrunet@baylibre.com>
Date:   Thu, 30 Apr 2020 05:54:24 +0400
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F65325B-9B07-4798-869E-7BA0E3E66E13@gmail.com>
References: <20200421163935.775935-1-jbrunet@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21 Apr 2020, at 8:39 pm, Jerome Brunet <jbrunet@baylibre.com> =
wrote:
>=20
> This patchset is adding the aiu support in DT and well as basic card
> support for the p230/q200 and libretech boards
>=20
> I was hoping to provide the internal codec support with this series =
but
> this is still blocked on the reset dt-bindings of the DAC [0].
>=20
> So far, things are fairly stable on these boards. I have experienced
> a few glitches on rare occasions. I have not been able to precisely =
found
> out why. It seems to be linked the AIU resets and 8ch support. Maybe =
more
> eyes (and ears) on this will help. If things get annoying and no =
solution
> is found, I'll submit a change to restrict the output to i2s 2ch.
>=20
> [0]: =
https://lore.kernel.org/r/20200122092526.2436421-1-jbrunet@baylibre.com

I have a reproducible way to provoke one glitch using Kodi but we can =
talk
about that off-list. Overall the series (and changes in [0] above) work
well and it=E2=80=99s great to see progress.

Tested-by: Christian Hewitt <christianshewitt@gmail.com>=
