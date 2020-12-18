Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0672DDD17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 03:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgLRCxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 21:53:35 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:53047 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgLRCxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 21:53:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608259990; h=Content-Type: MIME-Version: Message-ID: Date:
 Subject: Cc: To: From: Sender;
 bh=ebTPNgHK0L+3PQYRyzj0hOaE/+/JSKPpAVccenwyp0g=; b=vk6c/b1+BntsIikJNRPOwjS085hE6i1f+vEsR4Y5grlJpIgyq+DKnP5tBko9MCU7yICTXou2
 2MY07iGQ1AbB13CexurhRoUDQjmkeBv7OrBID02s2JKQGyJu/Ori5o+ywUMgYRTQetWNQbfB
 SVfrSp5+jf5sNswK2lyP6/X3a9E=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fdc1994f5e9af65f88e3025 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 02:53:08
 GMT
Sender: mengw=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70AE4C43463; Fri, 18 Dec 2020 02:53:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_05,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from mengw03 (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mengw)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C54CC433CA;
        Fri, 18 Dec 2020 02:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C54CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mengw@codeaurora.org
From:   <mengw@codeaurora.org>
To:     <myungjoo.ham@samsung.com>, <cw00.choi@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <plai@codeaurora.org>
Subject: Recall: extcon: add EXTCON_JACK_UNSUPPORTED for external headset jack
Date:   Fri, 18 Dec 2020 10:53:03 +0800
Message-ID: <!&!LgAAAAAAAAB19i+0qN0BRYnou6+9xQsSAQDDto4Q93URzrTNAKoAu7bmAAAAAAAOAABGAAAAAAAAAHX2L7So3QFFiei7r73FCxIHAMO2jhD3dRHOtM0AqgC7tuYAAAAAAA4AAM6huCz+NjFBpnM+pqhie+kAAAAADAEAAAAAAAAQAAAAA9+sgWAmFUOzmRJaVVysKD4AAABleHRjb246IGFkZCBFWFRDT05fSkFDS19VTlNVUFBPUlRFRCBmb3IgZXh0ZXJuYWwgaGVhZHNldCBqYWNrAA==@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0028_01D6D52B.F7C52210"
X-Mailer: Microsoft Outlook 16.0
X-MS-TNEF-Correlator: 0000000075F62FB4A8DD014589E8BBAFBDC50B120700C3B68E10F77511CEB4CD00AA00BBB6E600000000000D0000CEA1B82CFE363141A6733EA6A8627BE90000000088030000
Expiry-Date: Sun, 20 Dec 2020 10:53:02 +0800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_0028_01D6D52B.F7C52210
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

mengw@codeaurora.org would like to recall the message, "extcon: add
EXTCON_JACK_UNSUPPORTED for external headset jack".

------=_NextPart_000_0028_01D6D52B.F7C52210
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

eJ8+IgcCAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA6f0AAAAAAADmAQEIgAcAEwAAAElQTS5PdXRs
b29rLlJlY2FsbACCBgEDkAYAGAYAABsAAAADACYAAQAAAAIBMQABAAAAsQEAAFBDREZFQjA5AAEA
AgDKAAAAAAAAADihuxAF5RAaobsIACsqVsIAAHBzdHByeC5kbGwAAAAAAAAAAOkv63WWUESGg7h9
5SKqSUgAAEMAOgBcAFUAcwBlAHIAcwBcAG0AZQBuAGcAdwBcAEEAcABwAEQAYQB0AGEAXABMAG8A
YwBhAGwAXABNAGkAYwByAG8AcwBvAGYAdABcAE8AdQB0AGwAbwBvAGsAXABtAGUAbgBnAHcAQABj
AG8AZABlAGEAdQByAG8AcgBhAC4AbwByAGcALgBvAHMAdAAAAC4AAAAAAAAAdfYvtKjdAUWJ6Luv
vcULEgEAw7aOEPd1Ec60zQCqALu25gAAAAAADgAARgAAAAAAAAB19i+0qN0BRYnou6+9xQsSBwDD
to4Q93URzrTNAKoAu7bmAAAAAAAOAADOobgs/jYxQaZzPqaoYnvpAAAAAAwBAAAAAAAAEAAAAAPf
rIFgJhVDs5kSWlVcrCg+AAAAZXh0Y29uOiBhZGQgRVhUQ09OX0pBQ0tfVU5TVVBQT1JURUQgZm9y
IGV4dGVybmFsIGhlYWRzZXQgamFjawAAAAAeAHAAAQAAAEgAAAABCVJlY2FsbDogZXh0Y29uOiBh
ZGQgRVhUQ09OX0pBQ0tfVU5TVVBQT1JURUQgZm9yIGV4dGVybmFsIGhlYWRzZXQgamFjawALAAEO
AQAAAAMAFA4BAAAAHgAoDgEAAAAzAAAAMDAwMDAwMDMBbWVuZ3dAY29kZWF1cm9yYS5vcmcBbWVu
Z3dAY29kZWF1cm9yYS5vcmcAAB4AKQ4BAAAAMwAAADAwMDAwMDAzAW1lbmd3QGNvZGVhdXJvcmEu
b3JnAW1lbmd3QGNvZGVhdXJvcmEub3JnAAAeAPo/AQAAABUAAABtZW5nd0Bjb2RlYXVyb3JhLm9y
ZwAAAAACAQBoAQAAABAAAAAD36yBYCYVQ7OZElpVXKwoAwBVgAggBgAAAAAAwAAAAAAAAEYAAAAA
GoUAAAEAAAALAB8OAQAAAAIB+A8BAAAAEAAAAL2+/xywbQpHiVqWWmyvakkCAfoPAQAAABAAAAB1
9i+0qN0BRYnou6+9xQsSAwD+DwUAAAACAQkQAQAAAAsBAAAHAQAAhgEAAExaRnW2OlMzAwAKAHJj
cGcxMjUiMgNDdGV4BUJiaf5kBAADMAEDAfcKgAKkA+T/BxMCgBBzAFAEVghVB7IRpScOUQMBAgBj
aArAc2XcdDIGAAbDEaUzBEYUN94wEqwRswjvCfc7GJ8OMHY1EaIMYGMAUAsJAWQzFjYW0AumIAeA
bmd3NkAFoAEAYQhwBbBhLhEFsGcgdwhgbGQgAGxpa2UgdG8gzRigYwdAAyB0aB9QB4GAc2FnZSwg
Ig7BQQWgbjogYWQfAEUAWFRDT05fSkEAQ0tfVU5TVVCAUE9SVEVEIAIQ7wXADsEEkQdAICAgIXAU
kcQgagDQayIuCqIKgAJ9JVAAAwAWEAAAAAADAA00/T+tDgMADzT9P60OAgEUNAEAAAAQAAAA6S/r
dZZQRIaDuH3lIqpJSAIB4mUBAAAAFAAAABIEQJ3cM8FFm90q9jWAPaYABBS9AgHjZQEAAAAVAAAA
FBIEQJ3cM8FFm90q9jWAPaYABBS9AAAAAgF/AAEAAACNAAAAMDAwMDAwMDA3NUY2MkZCNEE4REQw
MTQ1ODlFOEJCQUZCREM1MEIxMjA3MDBDM0I2OEUxMEY3NzUxMUNFQjRDRDAwQUEwMEJCQjZFNjAw
MDAwMDAwMDAwRDAwMDBDRUExQjgyQ0ZFMzYzMTQxQTY3MzNFQTZBODYyN0JFOTAwMDAwMDAwODgw
MzAwMDAAAAAAAwAGEHlMgl0DAAcQZgAAAAMAEBAAAAAAAwAREAEAAAAeAAgQAQAAAGUAAABNRU5H
V0BDT0RFQVVST1JBT1JHV09VTERMSUtFVE9SRUNBTExUSEVNRVNTQUdFLCJFWFRDT046QURERVhU
Q09OSkFDS1VOU1VQUE9SVEVERk9SRVhURVJOQUxIRUFEU0VUSkFDAAAAAGeG

------=_NextPart_000_0028_01D6D52B.F7C52210--

