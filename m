Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2691B1DCC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 13:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgEULyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 07:54:15 -0400
Received: from v6.sk ([167.172.42.174]:35258 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbgEULyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:54:14 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id ECA61610A5;
        Thu, 21 May 2020 11:54:12 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mfd: Add ENE KB3930 Embedded Controller driver
Date:   Thu, 21 May 2020 13:54:05 +0200
Message-Id: <20200521115407.2249702-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying the patches chained to this message. It's the
fourth version of the driver for the ENE KB3930 Embedded Controller.

This version attempts to address the issues pointed out in review of v3.
A more detailed change log it in the patch description of patch 2/2.

Thanks,
Lubo



