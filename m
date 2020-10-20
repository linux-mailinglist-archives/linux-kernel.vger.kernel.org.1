Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD8294373
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 21:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438330AbgJTTqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 15:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438322AbgJTTqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:46:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F2CC0613CE;
        Tue, 20 Oct 2020 12:46:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dt13so4487243ejb.12;
        Tue, 20 Oct 2020 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQdN4e8sb8e85GEPtGpigBDe2ADdz+RJ3oBJUBCMZjg=;
        b=gIhnws7aM+fhvCkD1Dt/BHUVIFG6DroGv/rxfklooMW5vCWf482Gu4p8ckgMuW8WcL
         eLD+e+KpW5LIimgMB656uVSMROGYZno9RdNzIH4at6TFo+cSt7PkpaNY7LqUNCgj5zMQ
         B/1Pgcy0N2mTbMCBGqfmFyLoBZuRyFi7ralUj1ZeIWdFvvFq9KyoBDRL72gpxtl9HvtQ
         sae1IKwYGdNOWPpRVrhwirqxPHFpkTfc3NCs1qVvKQmCe0UklDV25OL7/F1IlXw3XrQw
         vN0yCy88mDOmbWf0wiXa3QiJh9DkjZSljx6wv5HuofImAbTiNhqRmT48yFQ1+d+uAESJ
         GALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQdN4e8sb8e85GEPtGpigBDe2ADdz+RJ3oBJUBCMZjg=;
        b=Ck2olbJqO1m60YRgiRRFAJ6k29aSoM8lJSGH4LlWfXcCXd7zNNIMDFrC6WE7OH6SpD
         /WfJG0G16ftKTAmN6reTvr6/AG1CMLhfagz7hwiNFurruwY8jF2cKDMFn8nNFR8XCWuM
         6zV+u34/G9Xet5TJJqnDjFKTWwGwpROCofk6foQLpwfRU9kAXsiIOILM2JtaKeDKeFqZ
         MzwpfU9KcOI/vquvrzN2rfN1Y0YCbAEejN5rt49/NXD8kEQPWYIrpevU7gk4Kl/+fkQd
         +StPjdqWnBpG3GO3QNyUhe5fccZnoxPzh9wnmuaAkTNTCzVPffpMmW7xh2K3bC9K+OJh
         oHaQ==
X-Gm-Message-State: AOAM530AWwcldgJxXxaSj7Lao6rv68xF81QIROqjzzDoQ19htPAB8JkY
        TBwR5vvm5FiH4TUf86rwOCcpkfxhmAAq2GyOxPTfx3Q2TOQ=
X-Google-Smtp-Source: ABdhPJx2MHroFdlTmNDtbUWu1ZhlQB87fZC12HOSohcHqgvy9QoA5Wfe/eetl1ZUEH7sy6RelMfaj7TmigG+twnT48s=
X-Received: by 2002:a17:906:1a10:: with SMTP id i16mr4812341ejf.162.1603223194667;
 Tue, 20 Oct 2020 12:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201020120141.298240-1-jbrunet@baylibre.com>
In-Reply-To: <20201020120141.298240-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Oct 2020 21:46:23 +0200
Message-ID: <CAFBinCBCxROWP2a1QG8Vuqr4x6U7ZkDb+Kdifv-M+06QN49GNg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: amlogic: add missing ethernet reset ID
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 2:10 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> From: Anand Moon <linux.amoon@gmail.com>
>
> Add reset external reset of the ethernet mac controller
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

note to self:
we're using the Ethernet reset on Meson8b and Meson8m2 for a long time
and I don't remember any problems with it *knocks on wood*
