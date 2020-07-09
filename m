Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A40A21AB43
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGIXMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:12:37 -0400
Received: from v6.sk ([167.172.42.174]:36624 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgGIXMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:12:37 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 1A16A60D19;
        Thu,  9 Jul 2020 23:12:36 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] mfd: Add ENE KB3930 Embedded Controller driver
Date:   Fri, 10 Jul 2020 01:12:26 +0200
Message-Id: <20200709231228.11564-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying the patches chained to this message. It's the
sixth version of the driver for the ENE KB3930 Embedded Controller.

This addresses responses to the fifth version of the set.
Detailed change logs are in the individual patch descriptions.

One thing that I was asked to do in the review of the previous version
that I didn't do is that I didn't expand the hardware vendor name,
"ENE". It's not an abbreviation.

Thanks,
Lubo



