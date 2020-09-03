Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF38325B80E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 02:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgICA63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 20:58:29 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:23040 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgICA6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 20:58:24 -0400
Date:   Thu, 03 Sep 2020 00:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599094699;
        bh=vloEJYPk3cOzYE9KOIO9k9lXOrvGtYw6KcGdO/0xwd8=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=cNQLIM+eHw8KG6XCi/afz+I2znn7owLUINU9dFFlpmmAX1XsPyVC/qcpfiMx6nsyU
         rgixiDBAuFMauhCxfXIFCC0joAsogABtWhseA2P38KF2i4ew/K0p241Oi6x0uzDwI9
         dg0lZisth3WQXO6ZR6lAwqWbTAJUUnOq6h+aSj9k=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH 0/2] docs: Add automatic cross-reference for C types
Message-ID: <20200903005747.3900333-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cross-reference C types in the documentation, Sphinx
requires the syntax :c:type:`type_name`, or even :c:type:`struct
type_name <type_name>` in order to have the link text different from the
target text.
This patch series removes the need for that markup.

The first commit extends the automarkup script to enable automatic
cross-reference of C types by matching any "struct|union|enum|typedef type_=
name"
expression.
This makes the documentation's plain text cleaner and adds cross-reference =
to
types without any additional effort by the author.

The second commit updates the "Cross-referencing from
reStructuredText" section in Documentation/doc-guide/kernel-doc.rst
to reflect that no additional syntax is needed when cross-referencing both =
types
and functions anymore.

When testing this, I did find an edge-case from the output of
Documentation/output/scsi/scsi_mid_low_api.rst on the "typedef struct scsi_=
cmnd
Scsi_Cmnd;", where 'typedef struct' is being identified as a reference, but
there isn't any named 'struct', so it renders bold.
I thought of adding an ignore_names list just like there is one for functio=
ns,
with 'struct' in it, to workaround this edge case, but since it was the onl=
y
one I found, and also because it was unclear what the desired output was
(cross-reference 'struct scsi_cmnd' or leave the whole expression as plain =
text)
I wanted to get some feedback beforehand.

After getting this merged I intend to start removing the occurrences of :c:=
type.

Thanks,
N=C3=ADcolas

N=C3=ADcolas F. R. A. Prado (2):
  docs: Add automatic cross-reference for C types
  kernel-doc: Update "cross-referencing from rST" section to use
    automarkup

 Documentation/doc-guide/kernel-doc.rst | 33 ++++++++++++-----------
 Documentation/sphinx/automarkup.py     | 37 +++++++++++++++++---------
 2 files changed, 41 insertions(+), 29 deletions(-)

--=20
2.28.0


