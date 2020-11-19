Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69162B98C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgKSQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:58:08 -0500
Received: from m1330.mail.163.com ([220.181.13.30]:4938 "EHLO
        m1330.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgKSQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:58:08 -0500
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Nov 2020 11:58:07 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=l6OD7
        0CTtbuimAxjzTPrDiLlxh09vruXljgMPT+Po5M=; b=lvcrw96LmqBYYaExybLfN
        Lxqa32+vBVFtKpVMc1sQzgYNjxduTPrIw8NErEgoFNDIJ+ynEGUwWIhq+8ifNFb7
        84VQb4g9AHiq8CkJ23XE17+ZMmTX6xtT6qWJnuk0G7ed5KvpAF45cNEjLFbd76rj
        FaCPu9Cl7SrXThys1tsuG4=
Received: from bbw725$163.com ( [222.130.132.250] ) by ajax-webmail-wmsvr30
 (Coremail) ; Fri, 20 Nov 2020 00:42:54 +0800 (CST)
X-Originating-IP: [222.130.132.250]
Date:   Fri, 20 Nov 2020 00:42:54 +0800 (CST)
From:   bbw725 <bbw725@163.com>
To:     linux-kernel@vger.kernel.org
Subject: ext2: How do we make sure indirect blocks are writeback before data
 block?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1d4ef9b2.81bf.175e1632bfb.Coremail.bbw725@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HsGowAAXEOiOoLZfyJqxAA--.4315W
X-CM-SenderInfo: peezljqv6rljoofrz/xtbBFQThKlXlmnbihgABsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsLAoKSSBoYXZlIG9uZSBxdWVzdGlvbiBhYm91dCBob3cgZXh0MiAncyBpbmRpcmVjdCBi
bG9jayBiZWluZyB3cml0ZSBiYWNrLiAoSSBrbm93IGV4dDIgaXMgb3V0IG9mIGRhdGUgYnV0IEkg
YW0ganVzdCBzdGFydGluZyBsZWFybmluZykuCgpGcm9tIGV4dDJfYWxsb2NfYnJhbmNoKCksIGFm
dGVyIGl0IGdvdCBpbmRpcmVjdCBibG9jayBhbmQgdGhlbiBpdCB3aWxsIHNldHVwIHRoZSAnY2hh
aW4nLCBkdXJpbmcgdGhpcywgaXQgd2lsbCBtYXJrIGJ1ZmZlciBoZWFkIG9mIGluZGlyZWN0IGJs
b2NrcyB0byBkaXJ0eSwgCmFuZCB0aGVuIHRoZSBpbm9kZSdzIGFzc29jaWF0ZWQgYmxvY2sgZGV2
IHdpbGwgd3JpdGUgYmFjayB0aGlzIGRpcnR5IGJ1ZmZlciBoZWFkLgpNeSBxdWVzdGlvbiBpcyB0
aGVzZSBpbmRpcmVjdCBibG9ja3MgYXJlIG1ldGEgZGF0YSBvZiB0aGlzIGlub2RlLCBhbmQgdXN1
YWxseSB3ZSBzaG91bGQgd3JpdGUgYmFjayBpbm9kZSdzIGRhdGEgZmlyc3QgYW5kIHRoZW4gaXRz
IG1ldGEgZGF0YSwgYnV0IGhlcmUsIGFmdGVyIHdlIG1hcmsgYnVmZmVyIGhlYWRzIG9mIGluZGly
ZWN0IGJsb2NrcyBhbmQgaG93IGRvIHdlIG1ha2Ugc3VyZSB0aGV5IHdpbGwgYmUgd3JpdHRlbiBi
YWNrIGJlZm9yZSBpdHMgZGF0YSA/CgoKZXh0Ml9hbGxvY19icmFuY2ggKC4uLikKewoKwqDCoMKg
ICAgICAgICAgICAgICAgIGJoID0gc2JfZ2V0YmxrKGlub2RlLT5pX3NiLCBuZXdfYmxvY2tzW24t
MV0pOwogICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCFiaCkpIHsKICAgICAgICAgICAgICAg
ICAgICAgICAgZXJyID0gLUVOT01FTTsKICAgICAgICAgICAgICAgICAgICAgICAgZ290byBmYWls
ZWQ7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBicmFuY2hbbl0uYmggPSBiaDsK
ICAgICAgICAgICAgICAgIGxvY2tfYnVmZmVyKGJoKTsKICAgICAgICAgICAgICAgIG1lbXNldChi
aC0+Yl9kYXRhLCAwLCBibG9ja3NpemUpOwogICAgICAgICAgICAgICAgYnJhbmNoW25dLnAgPSAo
X19sZTMyICopIGJoLT5iX2RhdGEgKyBvZmZzZXRzW25dOwogICAgICAgICAgICAgICAgYnJhbmNo
W25dLmtleSA9IGNwdV90b19sZTMyKG5ld19ibG9ja3Nbbl0pOwogICAgICAgICAgICAgICAgKmJy
YW5jaFtuXS5wID0gYnJhbmNoW25dLmtleTsKICAgICAgICAgICAgICAgIGlmICggbiA9PSBpbmRp
cmVjdF9ibGtzKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIGN1cnJlbnRfYmxvY2sgPSBuZXdf
YmxvY2tzW25dOwogICAgICAgICAgICAgICAgICAgICAgICAvKgogICAgICAgICAgICAgICAgICAg
ICAgICAgKiBFbmQgb2YgY2hhaW4sIHVwZGF0ZSB0aGUgbGFzdCBuZXcgbWV0YWJsb2NrIG9mCiAg
ICAgICAgICAgICAgICAgICAgICAgICAqIHRoZSBjaGFpbiB0byBwb2ludCB0byB0aGUgbmV3IGFs
bG9jYXRlZAogICAgICAgICAgICAgICAgICAgICAgICAgKiBkYXRhIGJsb2NrcyBudW1iZXJzCiAg
ICAgICAgICAgICAgICAgICAgICAgICAqLwogICAgICAgICAgICAgICAgICAgICAgICBmb3IgKGk9
MTsgaSA8IG51bTsgaSsrKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICooYnJhbmNo
W25dLnAgKyBpKSA9IGNwdV90b19sZTMyKCsrY3VycmVudF9ibG9jayk7CiAgICAgICAgICAgICAg
ICB9CiAgICAgICAgICAgICAgICBzZXRfYnVmZmVyX3VwdG9kYXRlKGJoKTsKICAgICAgICAgICAg
ICAgIHVubG9ja19idWZmZXIoYmgpOwogICAgICAgICAgICAgICAgbWFya19idWZmZXJfZGlydHlf
aW5vZGUoYmgsIGlub2RlKTsgICAKICAgICAgICAgICAgICAgIC8qIFdlIHVzZWQgdG8gc3luYyBi
aCBoZXJlIGlmIElTX1NZTkMoaW5vZGUpLgogICAgICAgICAgICAgICAgICogQnV0IHdlIG5vdyBy
ZWx5IHVwb24gZ2VuZXJpY193cml0ZV9zeW5jKCkKICAgICAgICAgICAgICAgICAqIGFuZCBiX2lu
b2RlX2J1ZmZlcnMuICBCdXQgbm90IGZvciBkaXJlY3Rvcmllcy4KICAgICAgICAgICAgICAgICAq
LwoKICAgICBUaGFua3MgdmVyeSBtdWNoLgoK
