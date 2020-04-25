Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9401B8820
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDYRbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 13:31:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:40642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYRbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:31:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09B95AE5E;
        Sat, 25 Apr 2020 17:31:38 +0000 (UTC)
Message-ID: <1587835881.19130.3.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Pete Zaitcev <zaitcev@redhat.com>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Sat, 25 Apr 2020 19:31:21 +0200
In-Reply-To: <Pine.LNX.4.44L0.2004231213260.20147-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2004231213260.20147-100000@netrider.rowland.org>
Content-Type: multipart/mixed; boundary="=-DJknTLj6xfyw8eo1K2Bh"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DJknTLj6xfyw8eo1K2Bh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Donnerstag, den 23.04.2020, 12:29 -0400 schrieb Alan Stern:
> On Thu, 23 Apr 2020, Oliver Neukum wrote:

> The only suspicious thing I see is that usblp_resume() calls 
> handle_bidir() without first acquiring any mutex.  But resume shouldn't 
> race with disconnect.

Right.

> The only other place where read URBs get submitted is under
> usblp_read(), which does acquire the mutex

Right.

>  and checks for disconnection
> while holding it.

Where? It should, but I do not see where it does so.

	Regards
		Oliver

--=-DJknTLj6xfyw8eo1K2Bh
Content-Disposition: attachment;
	filename="0001-usblp-fix-race-between-disconnect-and-read.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-usblp-fix-race-between-disconnect-and-read.patch";
	charset="UTF-8"

RnJvbSA4OWRiNTIzMmI0ZGY1Njk3MmQyODRjMTJmZDFiYjhlNDRmYjgxZTdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBXZWQsIDIyIEFwciAyMDIwIDEzOjE0OjI1ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gdXNibHA6
IGZpeCByYWNlIGJldHdlZW4gZGlzY29ubmVjdCgpIGFuZCByZWFkKCkKCnJlYWQoKSBuZWVkcyB0
byBjaGVjayB3aGV0aGVyIHRoZSBkZXZpY2UgaGFzIGJlZW4KZGlzY29ubmVjdGVkIGJlZm9yZSBp
dCB0cmllcyB0byB0YWxrIHRvIHRoZSBkZXZpY2UuCgpTaWduZWQtb2ZmLWJ5OiBPbGl2ZXIgTmV1
a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpSZXBvcnRlZC1ieTogc3l6Ym90K2JlNWI1Zjg2YTE2MmE2
YzI4MWU2QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KLS0tCiBkcml2ZXJzL3VzYi9jbGFzcy91
c2JscC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2NsYXNzL3VzYmxwLmMgYi9kcml2ZXJzL3VzYi9jbGFzcy91c2Js
cC5jCmluZGV4IDBkOGUzZjM4MDRhMy4uZmJjODI5OGM1Zjg0IDEwMDY0NAotLS0gYS9kcml2ZXJz
L3VzYi9jbGFzcy91c2JscC5jCisrKyBiL2RyaXZlcnMvdXNiL2NsYXNzL3VzYmxwLmMKQEAgLTgy
Niw2ICs4MjYsMTEgQEAgc3RhdGljIHNzaXplX3QgdXNibHBfcmVhZChzdHJ1Y3QgZmlsZSAqZmls
ZSwgY2hhciBfX3VzZXIgKmJ1ZmZlciwgc2l6ZV90IGxlbiwgbG8KIAlpZiAocnYgPCAwKQogCQly
ZXR1cm4gcnY7CiAKKwlpZiAoIXVzYmxwLT5wcmVzZW50KSB7CisJCWNvdW50ID0gLUVOT0RFVjsK
KwkJZ290byBkb25lOworCX0KKwogCWlmICgoYXZhaWwgPSB1c2JscC0+cnN0YXR1cykgPCAwKSB7
CiAJCXByaW50ayhLRVJOX0VSUiAidXNibHAlZDogZXJyb3IgJWQgcmVhZGluZyBmcm9tIHByaW50
ZXJcbiIsCiAJCSAgICB1c2JscC0+bWlub3IsIChpbnQpYXZhaWwpOwotLSAKMi4xNi40Cgo=


--=-DJknTLj6xfyw8eo1K2Bh--

