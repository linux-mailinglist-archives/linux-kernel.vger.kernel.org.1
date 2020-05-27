Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8771E34F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 03:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgE0Bst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 21:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgE0Bst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:48:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78235207CB;
        Wed, 27 May 2020 01:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590544128;
        bh=VZwcUR9cJJ5Xu2VihzOLcu/j5MKsW+XtUi/R0QgbwUw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hk2+02Bi3/1PeI7+An0+K2JTNQSaqNnXeXmc24FjgomYp+FUKQfSUw6UGEd7oNxnE
         D9Z/pUExuq9THOLTg9PAKUx3sU5T4/bq95CkfGVruMnIJbaqt4etVrkVZ7X+xgBcs2
         61fQWm/nrfti/FenmV7aih1qvNA5eLusl7zBPQdw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8dce2be13195aab20c6b11fca6af0fffe22d5241.1587102634.git.rahul.tanwar@linux.intel.com>
References: <cover.1587102634.git.rahul.tanwar@linux.intel.com> <8dce2be13195aab20c6b11fca6af0fffe22d5241.1587102634.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: clk: intel: Add bindings document & header file for CGU
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Tue, 26 May 2020 18:48:47 -0700
Message-ID: <159054412768.88029.14426898331029456551@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-04-16 22:54:46)
> Clock generation unit(CGU) is a clock controller IP of Intel's Lightning
> Mountain(LGM) SoC. Add DT bindings include file and document for CGU clock
> controller driver of LGM.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---

Applied to clk-next
