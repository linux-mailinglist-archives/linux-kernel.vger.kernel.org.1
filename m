Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6729CA03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831124AbgJ0URs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:17:48 -0400
Received: from mail-02.mail-europe.com ([51.89.119.103]:57608 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410303AbgJ0URs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:17:48 -0400
Date:   Tue, 27 Oct 2020 20:17:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603829864;
        bh=lNOiQB9wCZ6mbZQHmSvqkD7c1Q8DVOTDGQdWEzReI/A=;
        h=Date:To:From:Reply-To:Subject:From;
        b=rijsejbd72PWURxKM+W5krf6t+SwgjxZQoO2RDw6qtXTSQv0yPdLkzB3kwdKdyA0B
         GopHN2DgFeiggEjXbW20VK6E0JMTevmzmxsnRMn98ZqVEjGBR6QFAMqCjXZlu4j4pT
         ou4VCU996Bzz7gp+CBAxE5LStqoVdFfP20K/nBFk=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?utf-8?Q?Rados=C5=82aw_Wyrzykowski?= <r.wyrz@protonmail.com>
Reply-To: =?utf-8?Q?Rados=C5=82aw_Wyrzykowski?= <r.wyrz@protonmail.com>
Subject: PROBLEM: Intermittent panics/oopses during boot - usually when mounting drives or loading AppArmor profiles
Message-ID: <cNhDZF1Eb5O9AcY57oSEykkhfZp71GBv58IC7Ub1BOj58am5kTZG5ycuD7m5oeSsR-dXS9K6Vvlesoy2iY0428hdYrgkAtT2Z6V6-oddzdQ=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For the last couple of months, I've been trying to write a "proper" bug rep=
ort
regarding boot problems I'm encountering since at least kernel 5.8.7. Since
this is my first kernel bug report and the errors seem to occur in several
different places, I tried following the documentation in admin-guide/report=
ing-
bugs.rst and am posting it here (though I realize it's likely to get lost).
The details are posted under the Bugzilla entry below:

https://bugzilla.kernel.org/show_bug.cgi?id=3D209911

Regards
Rados=C5=82aw Wyrzykowski
