Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFA02226A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 17:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgGPPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 11:14:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46766 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGPPOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:14:18 -0400
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:95f7:ce7f:fb76:c54a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D3DAE2A0DFF;
        Thu, 16 Jul 2020 16:14:16 +0100 (BST)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     alsa-devel@alsa-project.org
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 0/2] ASoC: fsl_asrc: improve clock selection and quality
Date:   Thu, 16 Jul 2020 17:13:50 +0200
Message-Id: <20200716151352.193451-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
References: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the automatic clock selection and enables internal
ratio in order to improve audio quality.

The clock selection patches have been set aside for now, as the
discussion is still ongoing regarding that matter.

v1 -> v2:
- compare clock indexes (and not the location in the clock table) to
  make sure input and output clocks are different

 Arnaud Ferraris(2):
   ASoC: fsl_asrc: make sure the input and output clocks are different
   ASoC: fsl_asrc: always use internal ratio

 sound/soc/fsl/fsl_asrc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


