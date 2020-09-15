Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50826ADE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgIOTpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgIOTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:43:35 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B88C06178B;
        Tue, 15 Sep 2020 12:43:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id j2so4196703eds.9;
        Tue, 15 Sep 2020 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcSO66tZ1+449n/ove9k/zl/ZApYu1cOtIa7l/SoDz4=;
        b=J2hKvjCgngd5ccVeeKAhzqduSNgyZjcUl4Z9d+mXzTCN4siCjHc6qQgQFmuhJiZE1B
         LbICe2Bc8o7RJNMKKwBmcNLjTMbFz2XTyK+ZRmeOz2Rt1rMA6Hw6iMqFbXqbhn6RCmig
         6gi8M1Y2n0PQ9kE9WgCXl3Ohq6ai1dXRupaw33L07F2D+BNA9thfaK1RNU+7GVSZDW/U
         qf8P60DBli6UxYR53+O7EjEuEdY+ubNAXoUlok7uQWEK5ALOiU1OchBpG6pmunsEKzzw
         7cF4VXegLKExCx1yYGk+wzAslxFuGxT8uX6e+3lvRqxohdWYJqPgEfDJDo6acs0e0ch9
         tjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcSO66tZ1+449n/ove9k/zl/ZApYu1cOtIa7l/SoDz4=;
        b=H1zJ0jqvAhoNhr30eha8cVr895Sfo9u7md6AE9YbDsRJhOr7h207oKEAymKH8GWjBu
         CJrS4PDrryyIQlHGZiYge6874V8qqRgWnZ+fgMCWarA+0EQdH/N4dtLUfnX2wJIGa2dU
         WyWzJGLpueh5p/d8eJIZHe6+kRlNySURnZtlaJn3jq0sUl63iCVOdnaCuSesQCzAWYKc
         uajlamsxSOuon+gsLjMq4DYAAE3+VpcI5t8pxY49f50ABEKN0wJ6WvGvZAviSWLfr8Qw
         AC8zuMJcUlRHuI99IFN/UUmzU77syhKv3Q9fqE++RqxCvqva998BP5uskX9Co2Qq4/8S
         PRXQ==
X-Gm-Message-State: AOAM531uIPgJE7obIKWnPX5GucrhE+7hk3cJWGoufhH3itsJTt0nabvC
        +NbjAGHQ99FRg/+P8iIwSC2jZvtiWcrGrdtkc65icpxLzb8=
X-Google-Smtp-Source: ABdhPJxrRIfLMWTyAPVPBm1cJsmzAyW4ujVnPid9dKUNUoxBOMKBx1oz+uRocPLFv5HVc3Ukz/w/DdLDfKDIfquMcEw=
X-Received: by 2002:a05:6402:ca7:: with SMTP id cn7mr23632046edb.143.1600199009281;
 Tue, 15 Sep 2020 12:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161654.24141-1-narmstrong@baylibre.com> <20200904161654.24141-2-narmstrong@baylibre.com>
In-Reply-To: <20200904161654.24141-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 21:43:18 +0200
Message-ID: <CAFBinCC4gy5zksKPrs4t0yu3U+4rFGy90BHRduQ4wyUOv2x_Nw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] dt-bindings: power: amlogic, meson-ee-pwrc:
 add Amlogic AXG power controller bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 6:17 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds the bindings of the Power Controller found in the Amlogic AXG SoCs.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
