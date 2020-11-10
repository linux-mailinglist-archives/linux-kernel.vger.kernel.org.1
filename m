Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B072ACF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgKJG0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:26:46 -0500
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:34775 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJG0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:26:45 -0500
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 7AF8A282FE5;
        Tue, 10 Nov 2020 14:26:40 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJAAOQDzDcbjqrJ8gOXru4r0.3.1604989600488.Hmail.wangqing@vivo.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gc2NoZWQvcnQsIHBvd2VycGM6IFByZXBhcmUgZm9yIFBSRUVNUFRfUlQ=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.157
In-Reply-To: <20201110071839.Horde.h-QuHo16fxj_ok8Qgdbdnw8@messagerie.c-s.fr>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [58.213.83.157) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 10 Nov 2020 14:26:40 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Tue, 10 Nov 2020 14:26:40 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0lNGEpPTB1NQxpNVkpNS09CQ0JNS0tOTkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU5CTU5PTU5MSkhLN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MTo6NCo*AT8YGREKCTFDHDQjCQ5PCUtVSFVKTUtPQkNCTUtKSk5OVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZTkNVSUpIVUNIVUpOTFlXWQgBWUFOQk9CNwY+
X-HM-Tid: 0a75b0d5c3029395kuws7af8a282fe5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PlF1b3RpbmcgV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT46Cj4KPj4gQWRkIFBSRUVNUFRf
UlQgb3V0cHV0IHRvIGRpZSgpLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFFpbmcgPHdhbmdx
aW5nQHZpdm8uY29tPgo+PiAtLS0KPj4gIGFyY2gvcG93ZXJwYy9rZXJuZWwvdHJhcHMuYyB8IDEw
ICsrKysrKysrKy0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvdHJhcHMuYyBiL2Fy
Y2gvcG93ZXJwYy9rZXJuZWwvdHJhcHMuYwo+PiBpbmRleCA1MDA2ZGNiLi42ZGZlNTY3Cj4+IC0t
LSBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvdHJhcHMuYwo+PiArKysgYi9hcmNoL3Bvd2VycGMva2Vy
bmVsL3RyYXBzLmMKPj4gQEAgLTI1OCw2ICsyNTgsMTQgQEAgc3RhdGljIGNoYXIgKmdldF9tbXVf
c3RyKHZvaWQpCj4+ICAJcmV0dXJuICIiOwo+PiAgfQo+Pgo+PiArI2lmZGVmIENPTkZJR19QUkVF
TVBUCj4+ICsjZGVmaW5lIFNfUFJFRU1QVCAiIFBSRUVNUFQiCj4+ICsjZWxpZiBkZWZpbmVkKENP
TkZJR19QUkVFTVBUX1JUKQo+PiArI2RlZmluZSBTX1BSRUVNUFQgIiBQUkVFTVBUX1JUIgo+PiAr
I2Vsc2UKPj4gKyNkZWZpbmUgU19QUkVFTVBUICIiCj4+ICsjZW5kaWYKPgo+SSBkb24ndCBsaWtl
IHRvbyBtdWNoIHRoYXQgZm9yZXN0IG9mICNpZmRlZnMuIElTX0VOQUJMRUQoKSBpcyBwcmVmZXJl
ZCAgCj53aGVuZXZlciBwb3NzaWJsZS4KPgo+PiArCj4+ICBzdGF0aWMgaW50IF9fZGllKGNvbnN0
IGNoYXIgKnN0ciwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIGxvbmcgZXJyKQo+PiAgewo+PiAgCXBy
aW50aygiT29wczogJXMsIHNpZzogJWxkIFsjJWRdXG4iLCBzdHIsIGVyciwgKytkaWVfY291bnRl
cik7Cj4+IEBAIC0yNjUsNyArMjczLDcgQEAgc3RhdGljIGludCBfX2RpZShjb25zdCBjaGFyICpz
dHIsIHN0cnVjdCBwdF9yZWdzICAKPj4gKnJlZ3MsIGxvbmcgZXJyKQo+PiAgCXByaW50aygiJXMg
UEFHRV9TSVpFPSVsdUslcyVzJXMlcyVzJXMgJXNcbiIsCj4+ICAJICAgICAgIElTX0VOQUJMRUQo
Q09ORklHX0NQVV9MSVRUTEVfRU5ESUFOKSA/ICJMRSIgOiAiQkUiLAo+PiAgCSAgICAgICBQQUdF
X1NJWkUgLyAxMDI0LCBnZXRfbW11X3N0cigpLAo+PiAtCSAgICAgICBJU19FTkFCTEVEKENPTkZJ
R19QUkVFTVBUKSA/ICIgUFJFRU1QVCIgOiAiIiwKPj4gKwkgICAgICAgU19QUkVFTVBULAo+PiAg
CSAgICAgICBJU19FTkFCTEVEKENPTkZJR19TTVApID8gIiBTTVAiIDogIiIsCj4+ICAJICAgICAg
IElTX0VOQUJMRUQoQ09ORklHX1NNUCkgPyAoIiBOUl9DUFVTPSIgX19zdHJpbmdpZnkoTlJfQ1BV
UykpIDogIiIsCj4+ICAJICAgICAgIGRlYnVnX3BhZ2VhbGxvY19lbmFibGVkKCkgPyAiIERFQlVH
X1BBR0VBTExPQyIgOiAiIiwKPj4gLS0KPj4gMi43LjQKPgo+SSdkIHByZWZlciB0byByZW1haW4g
aW4gbGluZSB3aXRoIHRoZSBleGlzdGluZyBhbmQgdXNlIElTX0VOQUJMRUQoKSAgCj5pbnN0ZWFk
IG9mICNpZmRlZnMsIHNlZSBiZWxvdzoKPgo+ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9rZXJu
ZWwvdHJhcHMuYyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvdHJhcHMuYwo+aW5kZXggNTAwNmRjYmUx
ZDlmLi5kZWM3YjgxYzcyYTQgMTAwNjQ0Cj4tLS0gYS9hcmNoL3Bvd2VycGMva2VybmVsL3RyYXBz
LmMKPisrKyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvdHJhcHMuYwo+QEAgLTI2MiwxMCArMjYyLDEx
IEBAIHN0YXRpYyBpbnQgX19kaWUoY29uc3QgY2hhciAqc3RyLCBzdHJ1Y3QgcHRfcmVncyAgCj4q
cmVncywgbG9uZyBlcnIpCj4gIHsKPiAgCXByaW50aygiT29wczogJXMsIHNpZzogJWxkIFsjJWRd
XG4iLCBzdHIsIGVyciwgKytkaWVfY291bnRlcik7Cj4KPi0JcHJpbnRrKCIlcyBQQUdFX1NJWkU9
JWx1SyVzJXMlcyVzJXMlcyAlc1xuIiwKPisJcHJpbnRrKCIlcyBQQUdFX1NJWkU9JWx1SyVzJXMl
cyVzJXMlcyVzICVzXG4iLAo+ICAJICAgICAgIElTX0VOQUJMRUQoQ09ORklHX0NQVV9MSVRUTEVf
RU5ESUFOKSA/ICJMRSIgOiAiQkUiLAo+ICAJICAgICAgIFBBR0VfU0laRSAvIDEwMjQsIGdldF9t
bXVfc3RyKCksCj4gIAkgICAgICAgSVNfRU5BQkxFRChDT05GSUdfUFJFRU1QVCkgPyAiIFBSRUVN
UFQiIDogIiIsCj4rCSAgICAgICBJU19FTkFCTEVEKENPTkZJR19QUkVFTVBUX1JUKSA/ICIgUFJF
RU1QVF9SVCIgOiAiIiwKPiAgCSAgICAgICBJU19FTkFCTEVEKENPTkZJR19TTVApID8gIiBTTVAi
IDogIiIsCj4gIAkgICAgICAgSVNfRU5BQkxFRChDT05GSUdfU01QKSA/ICgiIE5SX0NQVVM9IiBf
X3N0cmluZ2lmeShOUl9DUFVTKSkgOiAiIiwKPiAgCSAgICAgICBkZWJ1Z19wYWdlYWxsb2NfZW5h
YmxlZCgpID8gIiBERUJVR19QQUdFQUxMT0MiIDogIiIsCj4tLS0KPkNocmlzdG9waGUKClllYWgs
IEkgYWdyZWUgd2l0aCBpdC4KCldhbmcgUWluZwoNCg0K
