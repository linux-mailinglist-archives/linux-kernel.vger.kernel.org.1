Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA53229FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbgGVTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 15:11:45 -0400
Received: from mailout06.rmx.de ([94.199.90.92]:52874 "EHLO mailout06.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732575AbgGVTLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:11:44 -0400
X-Greylist: delayed 1923 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 15:11:43 EDT
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout06.rmx.de (Postfix) with ESMTPS id 4BBklZ1dR6z9yJT;
        Wed, 22 Jul 2020 20:39:38 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BBklC2LPTz2xDP;
        Wed, 22 Jul 2020 20:39:19 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.68) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 22 Jul
 2020 20:39:12 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add two new configuration drivers for Microchip USB hubs
Date:   Wed, 22 Jul 2020 20:38:55 +0200
Message-ID: <20200722183859.24470-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.68]
X-RMX-ID: 20200722-203923-4BBklC2LPTz2xDP-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most USB hub chips from Microchip can be configured via I2C/SMBus
interface. The series adds two new drivers for configuration of the
following USB hub series:

- USB253x
- USB3x13
- USB46x4
- USB47xx
- USB49xx


