Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E26E2F2E47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbhALLpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:45:47 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:13068 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbhALLpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610451714;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:Message-Id:Cc:Date:From:Subject:From:Subject:Sender;
        bh=EpwVukQQ+OYL/SNYIYJknXafUxWYO+RYpZDfwGwh/2o=;
        b=XFIe0mFc1yH/WLHpCjj1WZ41BxgXq/mH8HHCh7VIaUxKsmiFL4j6x+O2MS1eF6YYPE
        UxWE4vjQb+0guCyFD6wTurZdXqq6D1C6GyR6GFB51IEyzvy4FJY0Si5WmgmO5/eHLSB9
        YpWPNkrJWZAQAOp+oMkcxcCcoRw666fBsh+5BIMkFxEmE+KFwINEHCAQY3Rx8E3sFRwG
        oCYeauUjKeawhceOwkFef96C4pWYZiA+px5FdyQv1hzMfJ8o28TzF6aF3GER9RGB5ITP
        0PYosqEjaUG3RA/zU5CWfgG6yC+ZftYq7kR8GWnDnhlPJ3QSnqHE0GrilyGbwYRvBmaS
        2+Qw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlSUXA0MbAo="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id m056b3x0CBfaU0W
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 12 Jan 2021 12:41:36 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: What ist the standard way to define connector type and bus format with device tree?
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Date:   Tue, 12 Jan 2021 12:41:36 +0100
Cc:     Paul Boddie <paul@boddie.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 7bit
Message-Id: <CD0942AC-045E-41A2-A24F-F368C9438899@goldelico.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
according to bindings/display/panel/panel-common.yaml
and by using "panel-simple" as compatible string we
can define almost all properties of a DSI panel by a
device tree entry.

Except the connector and bus format which can only be
set by adding the same information to the panel-simple tables.

This leads to big problems because DRM can't match the
display with any lcd controller. The least issue is a
warning:

[    0.313431] panel-simple claa070vc01: Specify missing connector_type

Are we missing some documentation or code that reads
some "connector-type" and "bus-format" property?

BR and thanks,
Nikolaus

