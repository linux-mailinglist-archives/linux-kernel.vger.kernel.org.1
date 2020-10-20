Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4296B2911F4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 15:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438014AbgJQNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 09:12:56 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:60992 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437990AbgJQNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 09:12:55 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 85AF3200870E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 13:12:53 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="IFh0eLdt"
Date:   Sat, 17 Oct 2020 13:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602940369;
        bh=Fsu0KIQhAmBwCSNdcOfR5NUAkTMf/tt4bnQkLN5yLFs=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=IFh0eLdt6BxcGrNi9dT+XA2FPBoyQU6n1P+Miq8yfHR+7/j0WA4bLoyjqECnLqsZN
         ErHY4JVhA2/XPt9qOPxai1r3dk0pXdc15vObUdUk6hh7fvGG9LCDWv0VdSFXx7zPNh
         BbH3OuVelWRfSg3OVt5c7Djp3L5MJxk8gzMVEXSU=
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: Announce loop-AES-v3.7s file/swap crypto package
Message-ID: <X9JUzx7zpthmi7qXRTK61kZC7JD-N7uWB1VJHrKAe5wfd4FpxYmBhTTfhlc05854jkpD2_4xwuJevhGB02KzYTi9T0KDxso7DftfvN04uc0=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.3 required=10.0 tests=ALL_TRUSTED,BITCOIN_SPAM_04,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        PDS_BTC_ID shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Worked around kernel interface changes on 5.9 kernels
- Partial re-write of ioctl handling to get rid of set_fs() which is
  expected to be removed from mainline kernels in near future.


bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7s.tar.bz2
    md5sum 154fabeb1976dc6dc111c96918d4c128

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.7s.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

