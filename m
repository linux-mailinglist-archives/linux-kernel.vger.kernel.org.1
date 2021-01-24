Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790A9301D15
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbhAXPOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:14:21 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:60485 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbhAXPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:13:38 -0500
Received: from [192.168.1.101] (abaf224.neoplus.adsl.tpnet.pl [83.6.169.224])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 0F0A93EB8B;
        Sun, 24 Jan 2021 16:12:36 +0100 (CET)
Subject: Re: [PATCH 1/3] arm64: dts: qcom: Add device tree for BQ Aquaris X5
 (Longcheer L8910)
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, stephan@gerhold.net,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20210124135409.5473-1-jonathan.albrieux@gmail.com>
 <20210124135409.5473-2-jonathan.albrieux@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <cb299b22-f00f-c8fd-648e-6f34c34b0967@somainline.org>
Date:   Sun, 24 Jan 2021 16:12:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210124135409.5473-2-jonathan.albrieux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sorting on smd_rpm_regulators & msmgpio seems off.. unless it's the new thing to put it at the end?

Also, did you forget the copyright header or is that on purpose?


Otherwise, LGTM


Konrad

