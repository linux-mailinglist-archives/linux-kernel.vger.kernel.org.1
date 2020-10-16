Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8E290707
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408724AbgJPORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395420AbgJPORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:17:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08180C061755;
        Fri, 16 Oct 2020 07:17:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id k9so2034059qki.6;
        Fri, 16 Oct 2020 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y2N9Ts5N7CVt9wr/ePD+KSf8C8M4q1OtWt2aeh5wg8c=;
        b=rS/jD8JMDzk/CgwwjSLV20MjwHgI1Uj3Et/bRjSP1Lw3GOCzh7bJun5b8O02chx2Mo
         O9/r+jPj0iki9GZ6z4HDf6SMMZ0Vm8EYHkmncqiC2/tvwi+OBGLuL/CFF8KOU/PcTCHJ
         8SsmxpfqgHWX68ROIVJkaxo+o6HwaSY4c6Zc5E3jNwk/c7CXVZ20kTtvXmdPa3rLWenW
         5WbWN5x/oHDlOtuHYu6DpTfQ3PGSYA4nIBFtW71I6SJXydES3FnsmU8ryD4vWInWckju
         2YxzyLhZp9YJ3tmuyB3SnuhLzYnQs+0ARCUQu1FnkFh29qUa/E6TgBvcWbui+cbR+oiO
         AVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y2N9Ts5N7CVt9wr/ePD+KSf8C8M4q1OtWt2aeh5wg8c=;
        b=EnaIb0wYYXGCrnWH9ZBo/2yFJlPbIPBVzrvKulZ3tvGAnJchbieLImRBUBJrTMBb/0
         MjnnNFMkUrESgkOo/oYBfHTMmBcDnljIj3/UtsMBXxSMxLyRZCSwt8ODAhtoN39dUEBx
         46U2930V6k0R8wIw8uTZ0phVbkmwYtGdUD6iDJAnc5pssFOR+ICHrqB+LK6W1/uCbAqt
         Sp7iw28VprA84FlIGs7SfK06tlzvd+xlnRkWhxWBaL40zysHmddsinExsTumrHIj07Ik
         RHkb4mwjrySX6Ro0pDskHaLa9QFdGSasJ93+Q6UMqSlvjqBrR93UpyrrilFRe29zHIoX
         3cZQ==
X-Gm-Message-State: AOAM530aMMRgNc/I9izEjgIyS8ZEoSARAn3KNqQDdZf02SDF1WgULKR6
        BNBnl0RJ5GwdRKOXWlG1Xro=
X-Google-Smtp-Source: ABdhPJz5G8Tza/D8Encg3kY9Xb3jwdS2iwgKlNCDyfpMMg3WySO1kAPX0r7PHPGeDRZwfQmuPWrZRw==
X-Received: by 2002:a05:620a:66d:: with SMTP id a13mr3973446qkh.301.1602857865155;
        Fri, 16 Oct 2020 07:17:45 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id n2sm1044448qtr.6.2020.10.16.07.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 07:17:44 -0700 (PDT)
Subject: Re: [PATCH 0/4] clk: add driver for the SiFive FU740
To:     Zong Li <zong.li@sifive.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, yash.shah@sifive.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <cover.1602838910.git.zong.li@sifive.com>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <d0627c5b-1007-bca0-e6d6-0a3740eaf6a7@gmail.com>
Date:   Fri, 16 Oct 2020 10:17:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cover.1602838910.git.zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 5:18 AM, Zong Li wrote:
> Add a driver for the SiFive FU740 PRCI IP block, which handles more
> clocks than FU540. These patches also refactor the original
> implementation by spliting the dependent-code of fu540 and fu740
> respectively.
> 
> Zong Li (4):
>   clk: sifive: Extract prci core to common base

I don't see this patch, and it isn't listed on the web archive. Was it
not CC'd to this list?

	--Sean

>   clk: sifive: Use common name for prci configuration
>   clk: sifive: Add a driver for the SiFive FU740 PRCI IP block
>   clk: sifive: Refactor __prci_clock array by using macro
> 
>  arch/riscv/Kconfig.socs                       |   2 +-
>  drivers/clk/sifive/Kconfig                    |   8 +-
>  drivers/clk/sifive/Makefile                   |   5 +-
>  drivers/clk/sifive/fu540-prci.c               | 618 +-----------------
>  drivers/clk/sifive/fu540-prci.h               |  21 +
>  drivers/clk/sifive/fu740-prci.c               | 102 +++
>  drivers/clk/sifive/fu740-prci.h               |  21 +
>  drivers/clk/sifive/sifive-prci.c              | 529 +++++++++++++++
>  drivers/clk/sifive/sifive-prci.h              | 297 +++++++++
>  include/dt-bindings/clock/sifive-fu740-prci.h |  23 +
>  10 files changed, 1032 insertions(+), 594 deletions(-)
>  create mode 100644 drivers/clk/sifive/fu540-prci.h
>  create mode 100644 drivers/clk/sifive/fu740-prci.c
>  create mode 100644 drivers/clk/sifive/fu740-prci.h
>  create mode 100644 drivers/clk/sifive/sifive-prci.c
>  create mode 100644 drivers/clk/sifive/sifive-prci.h
>  create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h
> 

