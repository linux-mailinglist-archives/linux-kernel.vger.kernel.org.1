Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36122206FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 11:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389018AbgFXJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 05:14:18 -0400
Received: from sonic301-2.consmr.mail.bf2.yahoo.com ([74.6.129.41]:34108 "EHLO
        sonic301-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387614AbgFXJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592990055; bh=0E9pdvweBu0fKCrAxtCtL115Ja1OOUibmQSYp1tYkKY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=hbj289La78DcG7/dx56YOklLwDbg/Db6pPyeylusQPOvPBLOinc6zIoFfNihz9CShU+1gms6SbN1utytN3Yopx0x7ltZz68ZjG2xJ/hagANq5y1dwJBLaRjES8I7yJ+XPtcOv7DVQxNBSTqtb4bqWQsuiellP7qSL6SCX5OltylORXinDuZ7cubpm2WyA6UxnAnJjo7scjUYhCP277phsk8rTvqmzsCXHHPVFjesGQ/CmUvf9NzXa+H22RvQQEkZ8oJ6DUieXDpMPse5JkYGaZZ7kyPGazsLAzU3Ek+SRkndrMxQX5WupsLRgJjj+RLoTi2seWQ4sBMG1Kjq2XXIZQ==
X-YMail-OSG: JR8mqfgVM1l7aPUmvZ7Du8.IfTAjRklB63I4wCoHCNtAoaMVNIoFiV3rtkfB7zA
 joR1utDn12U0VMHVSjU7zYD3loe1uZNRgHaS.bHecxxfWpMZcrd9z0eF.1BTyyghJGjBll4YJtc8
 c78.Je9UoqEJuQ360CkSINtNi1EIgP_peqBqrdHnXKwjRnGgTASIoZDbgS5y9LEJ__77EvbLECq2
 uWc8SKtLn_BuIxHgjerWtfF3u5.9RY9YTyQlVWVSpj9payjFyfnnfQUEDxaUlF5InWU4DlaWQKnx
 WmrI03fkItTRJYMfQ2i2lybnpYUsxYzVQT.Zcd.yBG0plEEaNz5aVx.OX.TF7moBdPiLiQkvrLsm
 vcXe46AOZYD0yz3FSMx3pYQDt2FI74ZiZ6Nx9vc1sZftZ049XhSOWn7_ZdHD3pUKbUgka1E7UKiK
 aGYZfiSyA103ZN.HKtcLkQHQ5BWH82oJqaP4VmQWIyR1y0evz7r5YvuTQA3A05o6a7JCu6ra8ndO
 FSk_WDofGnyzAMxVsHtWLZG3jHPa044o41UOfOVQiDOuBUSNaypOIrAk0d2lDS4lkLDm3MSc1fJU
 REAcFElVKKjBVL5mhsK_g37RsY_FmSHvW6TMNUo15jEEETguAdLQiVGyFppq8cXfCNwWiOBicYOP
 a33eYr4wd7p8zcaUlRw65rJtjMv4kIJobRWpcgcJysnzRkJFPoMzmIMhy8aWDtZoEUjmi5UrY9tJ
 WJRXI8t1J17kYMxqyrYOv2k5RD38kobFn29YaszlkiUo_rvH5_FDbzY9NM_MA5J2itGpLB_PkqI0
 HqekpGbLSnVeqS2wHv8LlJ1J9MQZW5ndHhapjzCsr9Og.hTquPSLvWQO5SuOsHZupFaY4e0xMeIr
 el.E8bnZJMkrQ5U_5DsTrWx99OrPw6sif1SsVCME6rRu3RUruiJKsi0y8RlAt_VZWHKMAlRPHkqH
 SRl2tkxajvT2heRwwHgA4I0_O7xMNtpevpix4_I2NqWOyEMok1t8CaWL0Qrb30tUtSHf2DqPFfWp
 x1Vy3l1q89gKCAHsktoEiuRiG95xUs2RpTcu96hsaaVRRFWyEMw3PJgCSAPF4.1IbQqzeZroxHTt
 m83E7EpugBMx7WH.6r2VWqViv1gL_Rpw.h265l9LD4yu9enKlUmJZGwkRj7y9X0pj6Kargcs1XAu
 56VJy60phQwEHuzh3OSbi5ZEeCN22m3MFkj8_svskQfNHbcYWvZ0dXhC7JS1yqNA2SGv7IR9V0GH
 mbTMuMFKvePRFdjyw_5ndmSxED75DfYJqqX.JDQSlAD7kS7DCAoRD6K11Lg.A104xoVoaUTU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 24 Jun 2020 09:14:15 +0000
Date:   Wed, 24 Jun 2020 09:14:14 +0000 (UTC)
From:   Mrs Sonia Wegari <davidbyrne1@frontier.com>
Reply-To: wegarisonia86@gmail.com
Message-ID: <194544754.2046048.1592990054998@mail.yahoo.com>
Subject: ..K...
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <194544754.2046048.1592990054998.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Attention: Beneficiary,
Be informed that we have verified your payment file as

directed to us and your name is next on the list of our outstanding fund
beneficiaries to receive their payment.
To facilitate with the process of this transaction,

please kindly re-confirm the following information below
1) Your Full Name
2) Your Full Address
3) Your Contact Telephone and Fax
4) Your Profession, Age and Marital Status
5) Any Valid Form of Your Identification/Driven License:
As soon as we receive
the above mentioned information, your payment will be processed and released
to you without any further delay.

This notification email should be your
confidential property to avoid impersonators claiming your fund. You are
required to provide the above information for your transfer to take place
through bank to bank transfer directly from Citibank.
We Look Forward To
Serving You Better.

Mrs Sonia Wegari
