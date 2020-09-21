Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFB273591
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgIUWR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:17:58 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:59122 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUWR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:17:58 -0400
Received: from macbookpro-ed.wildgooses.lan (unknown [212.69.38.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: ed@wildgooses.com)
        by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4BwJjH2PV3zTh56;
        Mon, 21 Sep 2020 23:17:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1600726676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FW8VSKIvyxeWBPbuPFvBD+ezdTOAwO9l2dhOnE9RnDg=;
        b=H3dySJfRCllaU4p4AvcexTteQ3Jambulzn/v1ogL3c/a7etWhop3XGKNKyMXVRab73AQpi
        mw3SgNKWzVJBvwK5AKJ47Hp7jtBKYDqG+/pgdRptyeBG3N8kiCGdCrt5N1s9e+GQSCEahU
        yzNWPBFWyOg2IftY6Mu7QwS1431ouzU=
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
From:   Ed W <lists@wildgooses.com>
Message-ID: <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
Date:   Mon, 21 Sep 2020 23:17:54 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921215919.3072-1-lists@wildgooses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've been adding support for the PC Engines APU5 board, which is a variant of the APU 2-4 boards
with some nice features. The current platform driver for pcengines boards has some redundant
features with regards to recent bios/firmware packages for the board as they now set the ACPI tables
to indicate GPIOs for keys and leds. So I've submitted a patch to eliminate this. It could be argued
that it's useful to support older firmware versions, but there is also a 'leds-apu' driver which a)
probably ought to be marked deprecated with a view to removing it and b) implements the leds even on
antique firmware versions.

In implementing the APU5 I changed some of the exported gpio names to make them more closely match
functionality across all the boards. For example APU2 vs APU4 both support 2x LTE options, but in
different mpcie slots and this affects the numbering of options, but not the sense of them (so I
renamed them based on the intention of the option). This is particularly true on APU5 which supports
3x LTE cards


Can I get some advice: It would be helpful if the kernel would export the GPIOs to user-space
automatically since toggling SIM slots is fairly useful task in userspace. At least for me the gpio
numbers seem to jump around depending on the order of module loading, so doing something involving
/sys/class/gpio/export isn't obviously an easy process. Reviewing the fine documentation suggests
that I need to use gpio_export() to achieve this, but I concede I'm really not clear how to
implement this in the platform module as currently structured... Any tips please?

Thanks

Ed W

