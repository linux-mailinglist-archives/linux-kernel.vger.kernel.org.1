Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7A245CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgHQHAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgHQHAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:18 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94CC62078A;
        Mon, 17 Aug 2020 07:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647618;
        bh=BByRPdtlmPBqiNYFQurdmSiKVxzMphseSv7+CP5W2Fw=;
        h=From:To:Subject:Date:From;
        b=EehskzrYLeh8tbHSTQM67ZrN76rYYsTKRoG2eA4WK2UOXYA9wYzgsk9kBZPDCAcrF
         zsIP3qPpSN9nGkTHceVYsNSfL7gfheC3zO8mgzpj1vUDUj5GWT4u+LbdezjFaGmSA8
         qfnC3wvZnQAoFJ/5FS4/2tV0J42BPHu0H2H5hIyA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
Date:   Mon, 17 Aug 2020 08:59:56 +0200
Message-Id: <20200817070009.4631-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
1. Mutex unlock fix in patch 8/13.

Best regards,
Krzysztof
