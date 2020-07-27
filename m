Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5322F2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 16:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgG0Osl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 10:48:41 -0400
Received: from mailout10.rmx.de ([94.199.88.75]:39453 "EHLO mailout10.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbgG0Osk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:48:40 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout10.rmx.de (Postfix) with ESMTPS id 4BFjNj0vdjz352w;
        Mon, 27 Jul 2020 16:48:37 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BFjNQ3BLkz2TRjr;
        Mon, 27 Jul 2020 16:48:22 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.121) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 27 Jul
 2020 16:48:01 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Christian Eggers" <ceggers@arri.de>
Subject: [PATCH] iio: light: Support AMS AS73211 digital XYZ sensor
Date:   Mon, 27 Jul 2020 16:47:39 +0200
Message-ID: <20200727144741.3927-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.121]
X-RMX-ID: 20200727-164830-4BFjNQ3BLkz2TRjr-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the AMS AS73211 digital XYZ sensor.


