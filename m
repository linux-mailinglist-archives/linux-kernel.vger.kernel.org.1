Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA172AF096
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgKKM1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:27:18 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13626 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgKKM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:27:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fabd8a30000>; Wed, 11 Nov 2020 04:27:16 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 12:27:08 +0000
Received: from audio.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Nov 2020 12:27:06 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/2] Refactor Audio Graph schema
Date:   Wed, 11 Nov 2020 17:56:51 +0530
Message-ID: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605097636; bh=B0Q1Meo9jLUCguFbXlLsBXwARLv5RaCTCbIMYbe/Rck=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=Le5VGkiz6kTxcA2kUyD8A79tXupLCjZrs5PWHxS1z7j+GgMTCnFcKQX1uPiDrcYUi
         N2U+57w971r26ENs6s7A2gR+NA8zLdkY3rZGTqaDDStdN4QNfFunkYhYNuT94Cd264
         IiyALLGwj3uSKfw2g37x7XoibBLoL9mugHXb1QP6qwGmka+/r80GoQzLbSSEMjmAlG
         3cI9EaFKsu3AhR13Pt8i3PYlnZaNPS20i+4EmSqV/3UkHLYir+9KHjLF5fMYPEn420
         kFSUQRz2ABnXqD6OH9AvTrA8KwarRXjli26sD6vx4id+UxcvcL4X7WlkuaEgGKhMIc
         3hwDXvqR9LBNQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be custom sound cards reusing most of the audio-graph
implementation. To allow this refactor the audio-graph-card schema into
following files.
 * audio-graph.yaml       : defines all common bindings
 * audio-graph-card.yaml  : define compatible property

Custom sound cards can just reference 'audio-graph.yaml' and define its
own compatible and specific properties.

This depends on following series:
http://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201102203656.220187-2-robh@kernel.org/

Sameer Pujar (2):
  ASoC: audio-graph-card: Refactor schema
  ASoC: renesas,rsnd: Update audio graph references

 .../bindings/sound/audio-graph-card.yaml           | 102 +-------------------
 .../devicetree/bindings/sound/audio-graph.yaml     | 107 +++++++++++++++++++++
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |   6 +-
 3 files changed, 112 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-graph.yaml

-- 
2.7.4

