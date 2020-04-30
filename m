Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228FF1BFF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD3Oyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgD3Oyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:54:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609FEC035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:54:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so2852878pgb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWdVwZpxTzIWQlIVn1v7lQVJtnSnYJZudWOQcLoP49I=;
        b=YAkERCzNfN7g+/n92gXNoXYjlC2ZipmRbAznjZ3wDFVgx/oWf9xt19ZwJeSEzUo9jZ
         jBhfxD5AnjQ4v2nAbD6uMxjlXZRIRl135ar8/cU1rQsVOKgNPsnxIVR3stT7J5IXsybR
         y4dBVVOYvIb9Obgk/yOwdIGkFQkuD6QIcxwCUYVY8/k+YRecMLvuaJv8+JhkG/+3gujS
         chGM8sbEwTffJ8KFa0cPqOuC2JNwI5wrmRBjCaNpdH0+60dLcJCBXVqnfMhQKe8nagzd
         xHv3ugV3D2JEiEDu5X41rWj+Z2X+ty9SWYj9/dofO/SQJmZyCE9OzRNgqs63X58Oez1r
         4+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWdVwZpxTzIWQlIVn1v7lQVJtnSnYJZudWOQcLoP49I=;
        b=Rpj9XWyznOIrwsnRWi9IE5SvjB2li+LXXjtzBKkiQAElgnhnnSKDoiaGIvIOurlPsX
         ptKO1U8TuwWaisgzaOeGFNmphCxaopV7+44qgkjQSGXMwUGJyG8+geZwtGSjDn1xphFx
         nDCrQSPJXLxhv3JnWRbsPgYNY//7Q8V/n4rLgi7sYj6ljgWFyAOP6w7PQ5CZw/hQTV54
         qEmyLQsVTUonJNU3N/xFTI7MkP4ojvPcSihfwgW91IcW4kero/NBpHOCwAvhNCH/nSiZ
         1Qae4ntiTKJsMy4cLcBuEqoKETefCXtt1s3NcZnV8QpjsaGCtww9v10NwsX4x97L9QWU
         OrUA==
X-Gm-Message-State: AGi0Puao71oj+GCUL0fmTdN718lz+V+81fRNuh78NaBgzne5sjtF7S6A
        4Brv3fsdgH7DbLQFlanLZFaC3A==
X-Google-Smtp-Source: APiQypJmRDIiwYQczCQ+RlC8U3mufvCX98/lwGUY9wB6oSl/i5kom+hz99JSzolzYsWmSJBSydECdQ==
X-Received: by 2002:a62:1549:: with SMTP id 70mr3671841pfv.43.1588258493773;
        Thu, 30 Apr 2020 07:54:53 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:da9d:67ff:fec6:ee6b])
        by smtp.gmail.com with ESMTPSA id x63sm108060pfc.56.2020.04.30.07.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:54:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: dts: meson-gx: add initial playback support
Date:   Thu, 30 Apr 2020 07:54:52 -0700
Message-Id: <158825831864.12709.14835236321376596645.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421163935.775935-1-jbrunet@baylibre.com>
References: <20200421163935.775935-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 18:39:29 +0200, Jerome Brunet wrote:
> This patchset is adding the aiu support in DT and well as basic card
> support for the p230/q200 and libretech boards
> 
> I was hoping to provide the internal codec support with this series but
> this is still blocked on the reset dt-bindings of the DAC [0].
> 
> So far, things are fairly stable on these boards. I have experienced
> a few glitches on rare occasions. I have not been able to precisely found
> out why. It seems to be linked the AIU resets and 8ch support. Maybe more
> eyes (and ears) on this will help. If things get annoying and no solution
> is found, I'll submit a change to restrict the output to i2s 2ch.
> 
> [...]

Queued for v5.8, thanks!

[1/6] arm64: defconfig: enable meson gx audio as module
      commit: cba26aef31ec791bc4d5ea13cb2c1288fcd95c0e
[2/6] arm64: dts: meson-gx: add aiu support
      commit: c531ca35ad54abcf6ceb35767ff25355557aa7ca
[3/6] arm64: dts: meson: p230-q200: add initial audio playback support
      commit: ace867239dd8059f2e92556895e7e13aea7b2e8a
[4/6] arm64: dts: meson: libretech-cc: add initial audio playback support
      commit: 9644eb9dc8bd1ac1112e267d771c6b492af1ff79
[5/6] arm64: dts: meson: libretech-ac: add initial audio playback support
      commit: 74c601fa46d109049472bb66adee88b3290b4bb8
[6/6] arm64: dts: meson: libretech-pc: add initial audio playback support
      commit: 1c75a81473153c211478e37152223aa585631b87

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
