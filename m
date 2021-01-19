Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF522FBD37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbhASRJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:09:45 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44878 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389514AbhASRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:07:33 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10JGvJHf017044;
        Tue, 19 Jan 2021 18:06:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=9+XDaRuw0yL8vET6emkwajCjVqUTYJZfQMDQ+4wuK48=;
 b=FS6+JApvF+fSNat6r4EY2oRSSotN31ihRGfpUVVoYZGfoClNNqZ6Bio4gSkEWprXlxOn
 oPtjW8LGiFZbufMYa57+ME3MdknzSDsTdRZ1weMvxF+6c4XodRhFEUwJBK4SBetun0vn
 g1LYT90BqojzNIdH/qJQ2F36JRmvEAuBmY2zDu6vlc9gifC7UWPQilePl5bB2DdhJm2s
 u83B2LoIBOuFX3cCDSmFW9GyFWLax1hBdqLLMwvpO/fcS3laLCw/PHwNZwyLDODwo0hz
 VPdg9pcxezDDRI76G9o4zzt6praChgyTFzYttO408/Jlly7O4oUUkC+UStfp6hRTzzK6 lA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 363qwnhu1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 18:06:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F24310009B;
        Tue, 19 Jan 2021 17:25:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EEB172B4D0C;
        Tue, 19 Jan 2021 17:24:59 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG1NODE3.st.com
 (10.75.127.3) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 17:24:59 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Tue, 19 Jan 2021 17:24:59 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     "aleksandr.o.makarov@gmail.com" <aleksandr.o.makarov@gmail.com>,
        "Andrzej Hajda" <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Antonio BORNEO <antonio.borneo@st.com>,
        "<dri-devel@lists.freedesktop.org>" <linux-kernel@vger.kernel.org>
Subject: RE: panel: panel-raydium68200 driver fails to write MIPI DSI init
 commands
Thread-Topic: panel: panel-raydium68200 driver fails to write MIPI DSI init
 commands
Thread-Index: AQHW6/xkkcQ363OJ+kOUgZU45z+WvaovH55A
Date:   Tue, 19 Jan 2021 16:24:59 +0000
Message-ID: <a855ddc858394a2492dce1ce3267946e@SFHDAG2NODE3.st.com>
References: <bf9ddf520b6f6f6d61123db02cd8fea10f495562.camel@gmail.com>
In-Reply-To: <bf9ddf520b6f6f6d61123db02cd8fea10f495562.camel@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_05:2021-01-18,2021-01-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbGVrc2FuZHIsDQoNCldlIHVzZSB0aGUgcmF5ZGl1bTY4MjAwIGljIGRyaXZlciBpbiBh
IGRzaSA3MjBwIDJkbCBwYW5lbCBtb2R1bGUgbW91bnRlZCBvbiB0aGUgTUIxMjMwIGJvYXJkIFsx
XSwgbW91bnRlZCBvbiB0aGUgU1RNMzJNUDE1NyBldmFsIGJvYXJkIFsyXS4NCg0KQWNjb3JkaW5n
IHRvIHlvdXIgZW1haWwsIHlvdSBhcmUgdXNpbmcgdGhlIEVEVCBFVE1MMDUwMEYzREhBIHBhbmVs
IG1vZHVsZSwgcHJvYmFibHkgY29tcG9zZWQgb2YgYSByYXlkaXVtNjgyMDArYSB0b3VjaHNjcmVl
bithIGdsYXNzK2JhY2tsaWdodCsuLi4uIA0KDQpDb3VsZCB5b3UgcGxlYXNlIGRvdWJsZSBjaGVj
ayBpZiB5b3VyIHBhbmVsIG1vZHVsZSBoYXMgdGhlIHNhbWUgY2hhcmFjdGVyaXN0aWNzIGFzIHRo
ZSBvbmUgZGVzY3JpYmVkIGluIHBhbmVsLXJheWRpdW02ODIwMC5jIChwaXhlbCBjbG9jaywgYmxh
bmtpbmcgdmFsdWVzLCByZXNvbHV0aW9ucywgbnVtYmVyIG9mIGRzaSBkYXRhIGxhbmVzLCBlbmFi
bGUgJiByZXNldCBncGlvcywgYmFja2xpZ2h0Li4uKS4NCg0KTW9yZW92ZXIsIG1heWJlIHlvdXIg
cGFuZWwgZW1iZWRzIGEgbm9uLXZvbGF0aWxlIHJhbSB3aGljaCBjb250YWlucyBuaWNlIGRlZmF1
bHQgdmFsdWVzICgiZnVzZWQiIGR1cmluZyBwcm9kdWN0aW9uKSBhbGxvd2luZyB0byByZWR1Y2Ug
YSBsb3QgdGhlIHBhbmVsIGluaXQgc2VxdWVuY2UuLi4gYWxsb3dpbmcgdGhlbiB0byB1c2UgcGFu
ZWwtc2ltcGxlLmMgaW5zdGVhZCBvZiBwYW5lbC1yYXlkaXVtNjgyMDAuYyAodGhhdCBjb3VsZCBl
eHBsYWluIHdoeSB5b3UgY2FuIHNlZSAiY29sb3JzIiB3aXRob3V0IHNlbmRpbmcgYW55IGluaXQg
c2VxdWVuY2UpLg0KDQpUaGUgaXNzdWVzIHlvdSBlbmNvdW50ZXJlZCBtYXkgY29tZSBmcm9tIChz
dGFydGluZyB3aXRoIHRoZSBoaWdoZXN0IHByb2JhYmlsaXR5KToNCiogYmFkIGxjZCBodyB2cyBz
dyBjb25maWd1cmF0aW9uIChzZWUgZGVzY3JpcHRpb24gYWJvdmUpLg0KKiBiYWQgcGl4ZWwgY2xv
Y2sgZnJlcXVlbmN5LCBiYWQgYmxhbmtpbmcgdmFsdWVzLi4uDQoqIGJhZCBkc2kgaW50ZXJuYWwg
Um9ja2NoaXAgaXAgcHJvZ3JhbW1pbmcgKHBsbCBhbmQgY2xvY2sgdHJlZXMgaW4gZHQuLi4pDQoN
CkhvcGUgaXQgaGVscHMsDQoNClsxXSBodHRwczovL3dpa2kuc3QuY29tL3N0bTMybXB1L3dpa2kv
TUIxMjMwDQpbMl0gaHR0cHM6Ly93d3cuc3QuY29tL2VuL2V2YWx1YXRpb24tdG9vbHMvc3RtMzJt
cDE1N2EtZXYxLmh0bWwNCg0KUGhpbGlwcGUgOi0pDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBhbGVrc2FuZHIuby5tYWthcm92QGdtYWlsLmNvbSA8YWxla3NhbmRyLm8ubWFr
YXJvdkBnbWFpbC5jb20+IA0KU2VudDogU2F0dXJkYXksIEphbnVhcnkgMTYsIDIwMjEgMTI6NDAN
ClRvOiBBbmRyemVqIEhhamRhIDxhLmhhamRhQHNhbXN1bmcuY29tPjsgTmVpbCBBcm1zdHJvbmcg
PG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPjsgTGF1cmVudCBQaW5jaGFydCA8TGF1cmVudC5waW5j
aGFydEBpZGVhc29uYm9hcmQuY29tPjsgSm9uYXMgS2FybG1hbiA8am9uYXNAa3dpYm9vLnNlPjsg
SmVybmVqIFNrcmFiZWMgPGplcm5lai5za3JhYmVjQHNpb2wubmV0PjsgRGF2aWQgQWlybGllIDxh
aXJsaWVkQGxpbnV4LmllPjsgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPjsgU2FtIFJh
dm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPjsgUGhpbGlwcGUgQ09STlUgPHBoaWxpcHBlLmNvcm51
QHN0LmNvbT47IEFudG9uaW8gQk9STkVPIDxhbnRvbmlvLmJvcm5lb0BzdC5jb20+OyA8ZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
DQpTdWJqZWN0OiBkcm06IHBhbmVsOiBwYW5lbC1yYXlkaXVtNjgyMDAgZHJpdmVyIGZhaWxzIHRv
IHdyaXRlIE1JUEkgRFNJIGluaXQgY29tbWFuZHMNCg0KSSBuZWVkIHRvIGJyaW5nIHVwIG15IE1J
UEkgRFNJIDEyODB4NzIwIEVEVCBFVE1MMDUwMEYzREhBIHBhbmVsIG9uIGENClJvY2tQcm82NCBW
Mi4xIGJvYXJkLg0KDQpUaGVyZSBpcyBubyBjb21wbGV0ZWx5IHN1aXRhYmxlIGluLXRyZWUgZHJp
dmVyIGZvciB0aGF0IHBhbmVsIHlldCwgYnV0IGZvciB0aGUgcHVycG9zZSBvZiByZXByb2R1Y2lu
ZyB0aGUgaXNzdWUgdGhhdCBJIGZhY2UsIHRoZSBncHUvZHJtL3BhbmVsL3BhbmVsLXJheWRpdW0t
cm02ODIwMC5jIGNhbiBkbyBqdXN0IGZpbmUuDQoNClRvIHJlcHJvZHVjZToNCg0KLSBHZXQgdGhl
IHNhbWUgTGludXggNS45LjE0IGFzIG9uIG15IFJvY2tQcm82NCBib2FyZCAod2l0aCBBcm1iaWFu
DQoyMC4xMS42IG9uIGl0KQ0KDQotIFBhdGNoIHRoZSByazMzOTktcm9ja3BybzY0LmR0cyB0byBh
ZGQgYSBwYW5lbCBub2RlIHRoYXQgaXMgY29tcGF0aWJsZSB3aXRoICJyYXlkaXVtLHJtNjgyMDAi
IGRyaXZlciBvbiBNSVBJIGludGVyZmFjZSAocm9ja3BybzY0LSBybTY4MjAwLnBhdGNoIGF0dGFj
aGVkKQ0KDQotIENvbXBpbGUgYW5kIHB1dCB0aGUgcmVzdWx0aW5nIHJrMzM5OS1yb2NrcHJvNjQu
ZHRiIG9uIHRoZSB0YXJnZXQgc3lzdGVtLiBUaGUgcGFuZWwgZHJpdmVyIHNoYWxsIHRoZW4gZ2V0
IHByb2JlZCBhdCBuZXh0IGJvb3QuDQoNClRoZSBrZXJuZWwgbG9nIHNoYWxsIGNvbnRhaW4gZm9s
bG93aW5nIGVycm9yczoNCg0KWyAgIDEwLjEzOTk1N10gZHctbWlwaS1kc2ktcm9ja2NoaXAgZmY5
NjAwMDAubWlwaTogZmFpbGVkIHRvIHdyaXRlDQpjb21tYW5kIEZJRk8NClsgICAxMC4xMzk5ODhd
IFtkcm06cm02ODIwMF9kY3Nfd3JpdGVfY21kLmlzcmEuNA0KW3BhbmVsX3JheWRpdW1fcm02ODIw
MF1dICpFUlJPUiogTUlQSSBEU0kgRENTIHdyaXRlIGZhaWxlZDogLTExMA0KWyAgIDEwLjE2MDk3
Ml0gZHctbWlwaS1kc2ktcm9ja2NoaXAgZmY5NjAwMDAubWlwaTogZmFpbGVkIHRvIHdyaXRlDQpj
b21tYW5kIEZJRk8NClsgICAxMC4xNjEwMDBdIFtkcm06cm02ODIwMF9kY3Nfd3JpdGVfYnVmLmlz
cmEuNQ0KW3BhbmVsX3JheWRpdW1fcm02ODIwMF1dICpFUlJPUiogTUlQSSBEU0kgRENTIHdyaXRl
IGJ1ZmZlciBmYWlsZWQ6IC0xMTANClsgICAxMC4xODE5MjldIGR3LW1pcGktZHNpLXJvY2tjaGlw
IGZmOTYwMDAwLm1pcGk6IGZhaWxlZCB0byB3cml0ZQ0KY29tbWFuZCBGSUZPDQpbICAgMTAuMTgx
OTUzXSBbZHJtOnJtNjgyMDBfZGNzX3dyaXRlX2J1Zi5pc3JhLjUNCltwYW5lbF9yYXlkaXVtX3Jt
NjgyMDBdXSAqRVJST1IqIE1JUEkgRFNJIERDUyB3cml0ZSBidWZmZXIgZmFpbGVkOiAtMTEwDQpb
ICAgMTAuMjAyOTIzXSBkdy1taXBpLWRzaS1yb2NrY2hpcCBmZjk2MDAwMC5taXBpOiBmYWlsZWQg
dG8gd3JpdGUNCmNvbW1hbmQgRklGTw0KWyAgIDEwLjIwMjk0N10gW2RybTpybTY4MjAwX2Rjc193
cml0ZV9idWYuaXNyYS41DQpbcGFuZWxfcmF5ZGl1bV9ybTY4MjAwXV0gKkVSUk9SKiBNSVBJIERT
SSBEQ1Mgd3JpdGUgYnVmZmVyIGZhaWxlZDogLTExMA0KWyAgIDEwLjIyMzA2NF0gZHctbWlwaS1k
c2ktcm9ja2NoaXAgZmY5NjAwMDAubWlwaTogZmFpbGVkIHRvIHdyaXRlDQpjb21tYW5kIEZJRk8N
ClsgICAxMC4yMjMwOTRdIFtkcm06cm02ODIwMF9kY3Nfd3JpdGVfYnVmLmlzcmEuNQ0KW3BhbmVs
X3JheWRpdW1fcm02ODIwMF1dICpFUlJPUiogTUlQSSBEU0kgRENTIHdyaXRlIGJ1ZmZlciBmYWls
ZWQ6IC0xMTANClsgICAxMC4yMjYxMDRdIHpyYW0xOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2Ug
ZnJvbSAwIHRvIDUyNDI4ODAwDQpbICAgMTAuMjQ0MDI3XSBkdy1taXBpLWRzaS1yb2NrY2hpcCBm
Zjk2MDAwMC5taXBpOiBmYWlsZWQgdG8gd3JpdGUNCmNvbW1hbmQgRklGTw0KWyAgIDEwLjI0NDA3
M10gW2RybTpybTY4MjAwX2Rjc193cml0ZV9idWYuaXNyYS41DQpbcGFuZWxfcmF5ZGl1bV9ybTY4
MjAwXV0gKkVSUk9SKiBNSVBJIERTSSBEQ1Mgd3JpdGUgYnVmZmVyIGZhaWxlZDogLTExMA0KWyAg
IDEwLjI2NTAyNF0gZHctbWlwaS1kc2ktcm9ja2NoaXAgZmY5NjAwMDAubWlwaTogZmFpbGVkIHRv
IHdyaXRlDQpjb21tYW5kIEZJRk8NClsgICAxMC4yNjUwNjRdIFtkcm06cm02ODIwMF9kY3Nfd3Jp
dGVfYnVmLmlzcmEuNQ0KW3BhbmVsX3JheWRpdW1fcm02ODIwMF1dICpFUlJPUiogTUlQSSBEU0kg
RENTIHdyaXRlIGJ1ZmZlciBmYWlsZWQ6IC0xMTANClsgICAxMC4yODU3MTFdIGR3LW1pcGktZHNp
LXJvY2tjaGlwIGZmOTYwMDAwLm1pcGk6IGZhaWxlZCB0byB3cml0ZQ0KY29tbWFuZCBGSUZPDQpb
ICAgMTAuMjg1NzQ2XSBbZHJtOnJtNjgyMDBfZGNzX3dyaXRlX2J1Zi5pc3JhLjUNCltwYW5lbF9y
YXlkaXVtX3JtNjgyMDBdXSAqRVJST1IqIE1JUEkgRFNJIERDUyB3cml0ZSBidWZmZXIgZmFpbGVk
OiAtMTEwDQpbICAgMTAuMzA1OTI2XSBkdy1taXBpLWRzaS1yb2NrY2hpcCBmZjk2MDAwMC5taXBp
OiBmYWlsZWQgdG8gd3JpdGUNCmNvbW1hbmQgRklGTw0KWyAgIDEwLjMwNTk1NV0gW2RybTpybTY4
MjAwX2Rjc193cml0ZV9idWYuaXNyYS41DQpbcGFuZWxfcmF5ZGl1bV9ybTY4MjAwXV0gKkVSUk9S
KiBNSVBJIERTSSBEQ1Mgd3JpdGUgYnVmZmVyIGZhaWxlZDogLTExMA0KWyAgIDEwLjMyNjk5Nl0g
ZHctbWlwaS1kc2ktcm9ja2NoaXAgZmY5NjAwMDAubWlwaTogZmFpbGVkIHRvIHdyaXRlDQpjb21t
YW5kIEZJRk8NClsgICAxMC4zMjcwMzldIFtkcm06cm02ODIwMF9kY3Nfd3JpdGVfYnVmLmlzcmEu
NQ0KW3BhbmVsX3JheWRpdW1fcm02ODIwMF1dICpFUlJPUiogTUlQSSBEU0kgRENTIHdyaXRlIGJ1
ZmZlciBmYWlsZWQ6IC0xMTANClsgICAxMC4zNDgwMzBdIGR3LW1pcGktZHNpLXJvY2tjaGlwIGZm
OTYwMDAwLm1pcGk6IGZhaWxlZCB0byB3cml0ZQ0KY29tbWFuZCBGSUZPDQpbICAgMTAuMzQ4MDc0
XSBbZHJtOnJtNjgyMDBfZGNzX3dyaXRlX2J1Zi5pc3JhLjUNCltwYW5lbF9yYXlkaXVtX3JtNjgy
MDBdXSAqRVJST1IqIE1JUEkgRFNJIERDUyB3cml0ZSBidWZmZXIgZmFpbGVkOiAtMTEwDQoNCkl0
J3MgcmVtYXJrYWJsZSB0aGF0IGlmIHRvIHB1bGwgdGhlIG1vZHVsZSBwYW5lbC1ybTY4MjAwMCBv
dXQgYW5kIHRoZW4gYmFjayBpbiwgdGhlcmUgYXJlIG5vIGVycm9ycyBtZW50aW9uZWQuIEkgY2Fu
IGZvciBzdXJlIHNheSB0aGF0IHRob3NlIGNvbW1hbmRzIGJlY29tZSBlZmZlY3RpdmUgLSBJIHN0
YXJ0IHNlZWluZyBjb2xvdXJmdWwgc3RyaXBlcyBvbiB0aGUgZGlzcGxheSBhZnRlci4gVGhhdCBp
cywgaWYgSSB3b3VsZCBzZW5kIHRoZSBjb3JyZWN0IGNvbW1hbmQgc2V0IHRvIHRoZSBwYW5lbCwg
dGhlbiBpdCB3b3VsZCBicmluZyB1cCBqdXN0IGZpbmUuIHRoZSBwYW5lbCwgdGhlbiBpdCB3b3Vs
ZCBicmluZyB1cCBqdXN0IGZpbmUuDQo=
