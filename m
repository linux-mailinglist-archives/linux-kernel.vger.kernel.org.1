Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0428FD5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbgJPEgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:36:17 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60931 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731890AbgJPEgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:36:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5A965F84;
        Fri, 16 Oct 2020 00:36:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 16 Oct 2020 00:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=tFx9y1gOlAAhTEgT/PH0isSwFS
        +k2LV4WaIJDM4cFVQ=; b=qBJyevLiNRwhAo/COPdxdQwigdwLM9BDJS0Sm6HKWk
        lNTt+5NNPiWfAprigBF7N7mXmkbjFHIUPVbEYqR10XOctsppSA4eeYZmhSq1VCcW
        Yq/J0U9Yx9dyhg/LXL/ktOgs0IlPSRDJU6FTdDyDpBB/PXuJSI4CKrYku6Ge+oT2
        8ACkJfMANUN+mfqDA+C0NUbM7krcU+myOn1LJe/opu61bLIdSpZcte2dJ0zOE1CZ
        tlHqJYudkAE+5xwquFoupagHtMZ1SbUsjDPpZFSLpaZSc3MglD0ugFkSgkTsGxnH
        PQHr302ZMgq6CeQVUZIaXazLAWhKRcqNAi9F3rVENHmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tFx9y1gOlAAhTEgT/
        PH0isSwFS+k2LV4WaIJDM4cFVQ=; b=cCAgUUAQoAqnYRfF6dq3ZcLdwxo0BS10w
        vZ5qoKQTsYWJYeiEOjCNmR2BCnURYw+bFe5Dwixw/eZjW3vpQGPMqh7T3rOKvPf6
        HnelX6TDYELG6Pfs7qE5Je21fstTN7iqfoTAo4wiby6j+7+VbjT3eiH2Qphz6T8D
        aNdPnZ9cMbd0BNIhKwu6w+on/1Cs5de7pCJ+4fLnb7CWQLRnAk/6Nnjtri8sCyhb
        wwAIonBfSq8RqvmKrNNEIhqsgXid1WsZ+zrsZ4xQ2pUfQmYGwcCktfz05gyAyr3v
        yuAyCiGaEtUPlOXigd5rqopxbb7pUSPp4v4OMhVlR3maiUEG7zLBQ==
X-ME-Sender: <xms:OyOJXwpmMsNXlED5iDcMNWDpX6i32I1OewH4Aax7A1h1WPF7yGCIAw>
    <xme:OyOJX2qKUGkhmZJ4LiCBOslucfSjQOkvBSmSPK2Sybzq7tWlWbo5Meq53b9-c21Qo
    HzAyxZTtTdT1Aus3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucggtffrrghtthgvrhhnpeekhfeiffejveefveehtdeiiefhfedvjeelvd
    dvtdehffetudejtefhueeuleeftdenucfkphepuddukedrvddutddrjedrudektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfi
    esrghjrdhiugdrrghu
X-ME-Proxy: <xmx:OyOJX1ODvrA-3lrx2i6JZOAEl7kbC_2qK5FwtLcgZmG6asxH9M6ydw>
    <xmx:OyOJX37ogbq8sOSxGyNeiftS70jZaNr6h9mgo1MfaSXfF2eEHOYveg>
    <xmx:OyOJX_71nPRFkOYhzto3gZdv9ZX_F2yBK2OYu9ci1WaPw8ln8UmAeg>
    <xmx:PCOJXxkqdQaw4134yjzKB61Pnb8ICZR0WLot1pLsQyubEZXjdDPisg>
Received: from localhost.localdomain (ppp118-210-7-180.adl-adc-lon-bras31.tpg.internode.on.net [118.210.7.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E764328005E;
        Fri, 16 Oct 2020 00:36:09 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: dts: Enable ramoops for Rainier and Tacoma
Date:   Fri, 16 Oct 2020 15:05:11 +1030
Message-Id: <20201016043513.119841-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We're looking to improve our crash data capture for the BMC on some IBM
platforms. This small series enables ramoops for Rainier and Tacoma.

Please review.

Andrew

Andrew Jeffery (2):
  ARM: dts: rainier: Add reserved memory for ramoops
  ARM: dts: tacoma: Add reserved memory for ramoops

 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 9 +++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 9 +++++++++
 2 files changed, 18 insertions(+)

-- 
2.25.1

